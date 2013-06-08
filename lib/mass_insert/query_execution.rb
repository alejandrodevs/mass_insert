module MassInsert
  # This class is responsible to execute the query string into the
  # database. Uses the ActiveRecord::Base.connection.execute functionality
  # to execute the query string directly.
  class QueryExecution

    attr_accessor :query_container

    # The query string is usually passed by params when the ProcessControl
    # class instances this class. The query can be a string or an array,
    # therefore to be sure that the query_container attribute is an array
    # the param passed to this class is converted to array. The query
    # container attribute will be iterated in execute method to execute
    # each query that it contains.
    def initialize query_container
      @query_container = Array(query_container)
    end

    # Saves queries contained in query_container attribute into database.
    # Use the helper that ActiveRecord provides. The query_container
    # attribute is iterated to save each query that it contains.
    def execute
      @query_container.each do |query|
        ActiveRecord::Base.connection.execute(query)
      end
    end

  end
end
