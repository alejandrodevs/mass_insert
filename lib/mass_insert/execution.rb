module MassInsert
  class Execution

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    def execute query
      ActiveRecord::Base.connection.execute(query)
    end

    def start
      execute(query)
    end

    def query
      MassInsert::QueryBuilder.new(values, options).execute
    end

  end
end
