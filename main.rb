require_relative 'server'

server = Server.new(5000)
trap('INT') { server.shutdown } # Encerra o servidor com CTRL+C
server.start