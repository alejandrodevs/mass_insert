module MassInsert
  module Adapters
    class Mysql2Adapter < Adapter

      # This method is overwrite because the timestamp format to this
      # database engine does not need precision in nanoseconds.
      def timestamp_format
        "%Y-%m-%d %H:%M:%S"
      end

      # This functions calls the necessary functions to create a complete
      # mysql query to multiple insertion. The methods are in the Abstract
      # Sql String module. If some method is too specific to this database
      # adapter you can overwrite it.
      def execute
        "#{begin_string}#{string_columns}#{string_values}"
      end

    end
  end
end
