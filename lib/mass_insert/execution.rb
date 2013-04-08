module MassInsert
  class Execution

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    def execute sql
      ActiveRecord::Base.connection.execute(sql)
    end

    def start
      execute(generate_sql)
    end

    def generate_sql
      MassInsert::QueryBuilder.new(values, options).build
    end

  end
end
