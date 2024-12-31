require 'socket'

server = TCPServer.new(5000)

# Aceitando conexões enquanto o loop estiver sendo executado
loop do
    # Aceita conexões simultâneas
    Thread.new(server.accept) do |socket|
        begin
            TIMEOUT = 10
            MAX_REQUESTS = 100
            request_count = 0
            loop do
                # Espera a leitura do socket por TIMEOUT segundos
                ready = IO.select([socket], nil, nil, TIMEOUT)
                break unless ready
                # Responde mensagem do cliente no socket
                line = socket.gets
                puts "O cliente disse: #{line}"
                socket.puts "Você disse: #{line}"
                # Conta as requisições
                request_count += 1
                break if request_count >= MAX_REQUESTS
            end
        rescue => e
            puts "Erro: #{e}"
        ensure
            socket.close
        end
    end
end