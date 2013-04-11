module MassInsert
  class QueryExecution

    attr_accessor :query

    def initialize query
      @query = query
    end

    # Saves the sql string into database. Use the helper that
    # ActiveRecord  provides.
    def execute
      ActiveRecord::Base.connection.execute(@query)
    end

  end
end
