module MassInsert
  module Executer
    # This class is responsible to execute the queries into the database.
    # Uses the ActiveRecord::Base.connection.execute functionality.
    class Base

      # Saves queries passed by param into database. Makes sure that the
      # param is an array using Array(param).
      def execute queries
        Array(queries).each do |query|
          ActiveRecord::Base.connection.execute(query)
        end
      end

    end
  end
end
