module MassInsert
  module Adapters
    class Sqlite3Adapter < Adapter

      # This functions calls the necessary functions to create a complete
      # mysql query to multiple insertion. The methods are in the Abstract
      # Sql String module. If some method is too specific to this database
      # adapter you can overwrite it.
      def execute
        begin_string << string_columns << string_values
      end

    end
  end
end
