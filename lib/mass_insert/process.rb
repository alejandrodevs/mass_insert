require 'benchmark'

module MassInsert
  class Process

    def initialize values, options
      @values  = values
      @options = options
    end

    # Calls necessary methods to complete mass insertion process and
    # saves the time that each method takes being executed.
    def start
      @building_time  = Benchmark.measure do
        @queries = builder.build(@values, @options)
      end

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
