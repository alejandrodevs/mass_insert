module MassInsert
  class ProcessControl

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    # This method is responsible to call all the necessary process to
    # complete the mass insertion process.
    def execute
      QueryExecution.new(query).execute
    end

    # Returns the correct query string  according to database adapter
    # previosly configured usually in database.yml in Rails project.
    def query
      QueryBuilder.new(values, options).build
    end

  end
end
