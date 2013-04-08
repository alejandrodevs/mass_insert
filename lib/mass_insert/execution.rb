module MassInsert
  class Execution
    include QueryBuilder

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
      generate_query
    end

  end
end
