require 'benchmark'

module MassInsert
  class ProcessControl

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    # This method is responsible to call all the necessary process to
    # complete the mass insertion process and save the time each method
    # takes being executed.
    def start
      # Calls the method that build the query.
      @build_time   = Benchmark.measure{ build_query }
      # Calls the method that execute the query.
      @execute_time = Benchmark.measure{ execute_query }
    end

    # This method does a QueryExecution instance where the query will be
    # execute. The query string is the instance variable @query.
    def execute_query
      QueryExecution.new(@query).execute
    end

    # Returns the correct query string  according to database adapter
    # previosly configured usually in database.yml in Rails project.
    def build_query
      @query = QueryBuilder.new(values, options).build
    end

  end
end
