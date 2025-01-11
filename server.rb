require 'socket'
require 'logger'
require 'openssl'

require_relative 'connection_pool'

class Server
    def initialize(host, port, max_connections)
        @timeout = 60
        @logger = Logger.new(STDOUT)
        $stdout.sync = true
        
        begin
            # Configura o servidor TCP e adiciona TLS
            tcp_server = TCPServer.new(host, port)
            @server = OpenSSL::SSL::SSLServer.new(tcp_server, configure_tls)
        rescue => e
            @logger.fatal "Erro ao configurar o servidor: #{e.message}"
            exit(1)
        end
        
        # Inicializa o pool de threads
        @connection_pool = ConnectionPool.new(max_connections, @logger)
        @logger.info "Servidor iniciado no endereço #{host} na porta #{port}"
    end 

    def start
        # Aceita conexões enquanto o loop estiver sendo executado
        loop do
            begin
                # Aceita conexões simultâneas
                socket = @server.accept
                @connection_pool.schedule(socket.peeraddr[3]) { handle_connection(socket) }
            rescue OpenSSL::SSL::SSLError => e
                @logger.error "Erro SSL ao aceitar conexão: #{e.message}"
                next
            rescue => e
                @logger.error "Erro inesperado ao aceitar conexão: #{e.message}"
                next
            end
        end
    end

    def shutdown
        @connection_pool.shutdown
        @server.close
    end

    private

    def handle_connection(socket)
        info = client_info(socket)
        @logger.info "Conexão estabelecida com #{info[:host]} (IP: #{info[:ip]}, Porta: #{info[:port]})"
        begin
            handle_client(socket)
        rescue => e
            @logger.error "Erro com o cliente #{info[:ip]}: #{e.message}"
        ensure
            @logger.info "Conexão encerrada com #{info[:ip]}"
            socket.close
        end
    end

    def handle_client(socket)
        info = client_info(socket)
        loop do
            # Espera a leitura do socket por TIMEOUT segundos
            ready = IO.select([socket], nil, nil, @timeout)
            if ready.nil?
                @logger.warn "Tempo de resposta excedido para #{info[:host]}"
                break
            end
            # Lê uma linha do socket
            line = socket.gets
            if line.nil?
                @logger.warn "Cliente #{info[:host]} encerrou a conexão"
                break
            end
            # Responde ao cliente no socket
            @logger.info "Mensagem recebida de #{info[:host]}: #{line.strip}"
            socket.puts line.strip
        end
    end

    def server_info
        addr = @server.addr
        { ip: addr[3], port: addr[1], host: addr[2] }
    end

    def client_info(socket)
        addr = socket.peeraddr
        { ip: addr[3], port: addr[1], host: addr[2] }
    end

    def configure_tls
        # Caminhos para o certificado e chave
        cert_path = 'certs/cert.pem'
        key_path = 'certs/key.pem'
        # Protocolos suportados pelo Servidor
        server_protocols = ["h2"]
        
        begin
            # Lê o certificado e a chave e armazena em variáveis
            cert = File.read(cert_path)
            key = File.read(key_path)
        rescue Errno::ENOENT => e
            @logger.fatal "Arquivo de certificado ou chave não encontrado: #{e.message}"
            raise
        rescue => e
            @logger.fatal "Erro inesperado ao ler os arquivos de certificado ou chave: #{e.message}"
            raise
        end
        
        begin
            # Cria contexto SSL
            context = OpenSSL::SSL::SSLContext.new
            # Configura o certificado e a chave no contexto SSL
            context.cert = OpenSSL::X509::Certificate.new(cert)
            context.key = OpenSSL::PKey::RSA.new(key)
            # Configura a negociação ALPN no contexto SSL
            context.alpn_protocols = server_protocols
            context.alpn_select_cb = lambda do |client_protocols|
                matching_protocols = client_protocols.find { |protocol| server_protocols.include?(protocol) }
                # Retorna erro se o Cliente e o Servidor não suportarem um mesmo protocolo
                unless matching_protocols
                    @logger.fatal "Protocolos #{client_protocols.join(" ")} não suportados pelo Servidor"
                    raise
                end
                matching_protocols
            end
        rescue OpenSSL::OpenSSLError => e
            @logger.fatal "Erro ao carregar o Certificado SSL/TLS: #{e.message}"
            raise
        rescue => e
            @logger.fatal "Erro inesperado ao configurar o contexto SSL/TLS: #{e.message}"
            raise
        end
        
        context
    end
end