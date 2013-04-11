module MassInsert
  # This class is responsible to execute the query string into the
  # database. Uses the ActiveRecord::Base.connection.execute functionality
  # to execute the query string directly.
  class QueryExecution

    attr_accessor :query

    # The query string is usually passed by params when the ProcessControl
    # class instances this class.
    def initialize query
      @query = query
    end

    # Saves the query string into database. Use the helper that ActiveRecord
    # provides. The query string that is saved into the database is passed
    # by params when is initialized the class. The sql string is stored in
    # the query instance variable.
    def execute
      ActiveRecord::Base.connection.execute(@query)
    end

  end
end
