module MassInsert
  module Adapters
    class SQLServerAdapter < Adapter

      MAX_VALUES_PER_INSERTION = 1000

      # This functions calls the necessary functions to create a complete
      # sqlserver query to multiple insertion. The methods are in the Abstract
      # Query module. If some method is too specific to this database adapter
      # you can overwrite it.
      def execute
        @values.each_slice(MAX_VALUES_PER_INSERTION).map do |slice|
          @values = slice
          begin_string << string_columns << string_values
        end
      end

    end
  end
end
