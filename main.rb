require_relative 'server'

server = Server.new('0.0.0.0', 5000, 4)
trap('INT') { server.shutdown } # Encerra o servidor com CTRL+C
server.start