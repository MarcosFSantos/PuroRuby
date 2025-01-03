class ThreadPool
    def initialize(size)
        @size = size # Número máximo de threads simultâneas
        @queue = Queue.new # Fila de tarefas
        @pool = Array.new(size) do
            Thread.new do
                task = @queue.pop # Pega uma tarefa da fila
                exit unless task
                task.call # Executa a tarefa
            end
        end
    end

    def schedule(&block)
        @queue << block # Adiciona uma tarefa à fila
    end

    def shutdown
        # Prepara a finalização das threads
        @size.times { @queue << nil }
        @pool.each(&:join)
    end
end