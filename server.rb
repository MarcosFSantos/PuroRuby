require 'socket'
require 'logger'
require 'openssl'

require_relative 'thread_pool'

class Server
    def initialize(host, port, thread_pool_size)
        @timeout = 60
        tcp_server = TCPServer.new(host, port)
        @server = OpenSSL::SSL::SSLServer.new(tcp_server, configure_tls)
        $stdout.sync = true
        @logger = Logger.new(STDOUT)
        @thread_pool = ThreadPool.new(thread_pool_size)
    end

    def start
        info = server_info
        @logger.info "Servidor iniciado no endereço #{info[:ip]} na porta #{info[:port]}"
        # Aceita conexões enquanto o loop estiver sendo executado
        loop do
            begin
                # Aceita conexões simultâneas
                socket = @server.accept
                @thread_pool.schedule { handle_connection(socket) }
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
        @thread_pool.shutdown
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

        # Ler o certificado e a chave e armazena em variáveis
        cert = File.read(cert_path)
        key = File.read(key_path)

        # Cria um contexto SSL e configura o certificado e a chave
        context = OpenSSL::SSL::SSLContext.new
        context.cert = OpenSSL::X509::Certificate.new(cert)
        context.key = OpenSSL::PKey::RSA.new(key)

        context
    end
end