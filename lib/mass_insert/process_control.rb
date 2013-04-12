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
      query = QueryBuilder.new(values, options).build
      QueryExecution.new(query).execute
    end

  end
end
