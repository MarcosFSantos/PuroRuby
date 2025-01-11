class ConnectionPool
    def initialize(max_connections, logger)
        @max_connections = max_connections # Número máximo de conexões simultâneas
        @logger = logger
        @queue = Queue.new # Fila de conexões
        @connections = {} # IPs dos clientes com conexões ativas
        @mutex = Mutex.new # Protege o acesso ao @connections
        @pool = Array.new(max_connections) do
            Thread.new do
                task, client = @queue.pop # Pega uma conexão da fila e o IP do cliente
                exit unless task
                begin
                    task.call # Executa a conexão
                ensure
                    @mutex.synchronize { @connections.delete(client) } # Remove o IP após a execução da tarefa
                end
            end
        end
    end

    def schedule(client, &block)
        @mutex.synchronize do
            if @connections.key?(client)
                @logger.error "O cliente #{client} já possui uma conexão ativa!"
            else
                @connections[client] = true # Adiciona o IP do cliente na lista conexões ativas
                @queue << [block, client] # Adiciona uma conexão à fila
            end
        end
    end

    def shutdown
        # Prepara a finalização das conexões
        @size.times { @queue << nil }
        @pool.each(&:join)
    end
end