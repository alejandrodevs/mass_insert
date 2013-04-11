module MassInsert
  class ProcessControl

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    def execute
      query_builder = QueryBuilder.new(values, options)
      query = query_builder.execute

      query_execution = QueryExecution.new(query)
      query_execution.execute
    end

  end
end
