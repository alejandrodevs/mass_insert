module MassInsert
  class Execution

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    # Saves the sql string into database. Use the helper that
    # ActiveRecord  provides.
    #
    #   ActiveRecord::Base.connection.execute(sql_string)
    def execute sql
      ActiveRecord::Base.connection.execute(sql)
    end

    # This function is called from Base module and starts the mass
    # database insertion. Calls the QueryBuilder class that builds
    # the sql string.
    def start
      execute(generate_sql)
    end

    # This function calls QueryBuilder class and returns the sql
    # string ready to be executed.
    def generate_sql
      MassInsert::QueryBuilder.new(values, options).build
    end

  end
end
