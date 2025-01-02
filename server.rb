require 'socket'

class Server
    def initialize(port)
        @timeout = 60
        @server = TCPServer.new(port)
    end

    def start
        puts "Servidor iniciado"
        # Aceita conexões enquanto o loop estiver sendo executado
        loop do
            # Aceita conexões simultâneas
            Thread.new(@server.accept) { |socket| handle_connection(socket) }
        end
    end

    def handle_connection(socket)
        puts "Conexão estabelecida"
        begin
            handle_client(socket)
        rescue => e
            puts "Erro: #{e}"
        ensure
            puts "Conexão encerrada"
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
            p line
            socket.puts "Você disse: #{line}"
        end
    end

    def shutdown
        @server.close
        puts "Servidor encerrado"
    end
end