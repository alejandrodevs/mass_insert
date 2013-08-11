require 'benchmark'
require 'ostruct'

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

    # Provides an OpenStruc instance to see the process results. This
    # method is usually called from mass_insert_results in Base module.
    def results
      result = OpenStruct.new
      result.time         = @building_time.total + @execution_time.total
      result.records      = @values.count
      result.build_time   = @building_time.total
      result.execute_time = @execution_time.total
      result
    end

  end
end
