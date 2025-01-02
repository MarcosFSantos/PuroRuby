require 'socket'

class Server
    def initialize(port)
        @timeout = 10
        @max_requests = 100
        @server = TCPServer.new(port)
    end

    def start
        # Aceitando conexões enquanto o loop estiver sendo executado
        loop do
            # Aceita conexões simultâneas
            Thread.new(@server.accept) do |socket|
                begin
                    request_count = 0
                    loop do
                        # Espera a leitura do socket por TIMEOUT segundos
                        ready = IO.select([socket], nil, nil, @timeout)
                        break unless ready
                        # Responde mensagem do cliente no socket
                        line = socket.gets
                        puts "O cliente disse: #{line}"
                        socket.puts "Você disse: #{line}"
                        # Conta as requisições
                        request_count += 1
                        break if request_count >= @max_requests
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