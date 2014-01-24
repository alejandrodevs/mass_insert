require 'benchmark'

module MassInsert
  class Process

    def initialize values, options
      @values  = values
      @options = options
    end

    def start
      # MassInsert process is completed by two actions. The first one
      # gets queries that will be persisted.
      @building_time  = Benchmark.measure do
        @queries = builder.build(@values, @options)
      end

      # The second one executes queries into the database using an
      # ActiveRecord connection.
      @execution_time = Benchmark.measure do
        executer.execute(@queries)
      end
    end

    def builder
      @builder ||= Builder::Base.new
    end

    def executer
      @executer ||= Executer.new
    end
  end
end
