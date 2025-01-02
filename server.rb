require 'socket'

class Server
    def initialize(port)
        @timeout = 60
        @server = TCPServer.new(port)
    end

    def start
        # Aceitando conexões enquanto o loop estiver sendo executado
        loop do
            # Aceita conexões simultâneas
            Thread.new(@server.accept) do |socket|
                begin
                    loop do
                        # Espera a leitura do socket por TIMEOUT segundos
                        ready = IO.select([socket], nil, nil, @timeout)
                        break unless ready
                        # Responde mensagem do cliente no socket
                        line = socket.gets
                        puts "O cliente disse: #{line}"
                        socket.puts "Você disse: #{line}"
                    end
                rescue => e
                    puts "Erro: #{e}"
                ensure
                    socket.close
                end
            end
        end
    end
end