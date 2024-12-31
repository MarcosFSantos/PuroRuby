require 'socket'

server = TCPServer.new(5000)

# Aceitando conexões enquanto o loop estiver sendo executado
loop do
    # Aceita conexões simultâneas
    Thread.new(server.accept) do |socket|
        begin
            # Responde mensagens do cliente no socket
            while line = socket.gets
                puts "O cliente disse: #{line}"
                socket.puts "Você disse: #{line}"
            end
        rescue => e
            puts "Erro: #{e}"
        end
    end
end