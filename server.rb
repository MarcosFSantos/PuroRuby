require 'socket'
require 'logger'

class Server
    def initialize(port)
        @timeout = 60
        @server = TCPServer.new(port)
        @logger = Logger.new(STDOUT)
    end

    def start
        @logger.info "Servidor iniciado"
        # Aceita conexões enquanto o loop estiver sendo executado
        loop do
            # Aceita conexões simultâneas
            Thread.new(@server.accept) { |socket| handle_connection(socket) }
        end
    end

    def handle_connection(socket)
        @logger.info "Conexão estabelecida"
        begin
            handle_client(socket)
        rescue => e
            @logger.error e
        ensure
            @logger.info "Conexão encerrada"
            socket.close
        end
    end

    def handle_client(socket)
        loop do
            # Espera a leitura do socket por TIMEOUT segundos
            ready = IO.select([socket], nil, nil, @timeout)
            break unless ready
            # Responde mensagem do cliente no socket
            line = socket.gets
            @logger.info line
            socket.puts "Você disse: #{line}"
        end
    end

    def shutdown
        @server.close
        @logger.info "Servidor encerrado"
    end
end