require 'benchmark'

module MassInsert
  class Process

    def initialize values, options
      @values  = values
      @options = options
    end

    # Calls the necessary methods to complete the mass insertion process
    # and the time that each method takes being executed.
    def start
      @building_time  = Benchmark.measure do
        @queries = Builder::Base.new.build(@values, @options)
      end

      @execution_time = Benchmark.measure do
        Executer.new.execute(@queries)
      end
    end

  end
end
