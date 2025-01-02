require 'socket'
require 'logger'
require_relative 'thread_pool'

class Server
    def initialize(port, thread_pool_size)
        @timeout = 60
        @server = TCPServer.new(port)
        @logger = Logger.new(STDOUT)
        @thread_pool = ThreadPool.new(thread_pool_size)
    end

    def start
        @logger.info "Servidor iniciado"
        # Aceita conexões enquanto o loop estiver sendo executado
        loop do
            # Aceita conexões simultâneas
            socket = @server.accept
            @thread_pool.schedule { handle_connection(socket) }
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
            if ready.nil?
                @logger.warn "Tempo de resposta excedido"
                break
            end
            # Lê uma linha do socket
            line = socket.gets
            if line.nil?
                @logger.warn "Cliente desconectado"
                break
            end
            # Responde ao cliente no socket
            @logger.info line
            socket.puts "Você disse: #{line}"
        end
    end

    def shutdown
        @thread_pool.shutdown
        @server.close
        @logger.info "Servidor encerrado"
    end
end