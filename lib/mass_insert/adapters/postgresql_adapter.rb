module MassInsert
  module Adapters
    class PostgreSQLAdapter < Adapter

      # This functions calls the necessary functions to create a complete
      # postgresql query to multiple insertion. The methods are in the
      # AbstractQuery module. If some method is too specific to this database
      # adapter you can overwrite it.
      def execute
        begin_string << string_columns << string_values
      end

    end
  end
end
