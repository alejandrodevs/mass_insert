module MassInsert
  module Adapters
    class SQLite3Adapter < Adapter

      MAX_VALUES_PER_INSERTION = 500

      # This method is overwrite and when is called by columns_name method
      # ignore the method that is in the Sanitizer module. It's over write
      # because the Sqlite3 adapter require other rules in its columns.
      def sanitized_columns
        table_columns
      end

      # This method is overwrite because the query string to the Sqlite3
      # adapter is different. Then the method in the AbstractQuery module
      # is ignored.
      def string_values
        "SELECT #{string_rows_values};"
      end

      # This method is overwrite because the query string to complete the
      # string rows values is different. The separator to sqlite adapter is
      # 'UNION SELECT' instead of '), (' in other sql adapters.
      def string_rows_values
        values.map{ |row| string_single_row_values(row) }.join(" UNION SELECT ")
      end

      def string_single_row_values row
        # Prepare the single row to be included in the sql string.
        row.merge!(primary_key_value)
        row.merge!(timestamp_values) if timestamp?

        # Generates the values to this row that will be included according
        # to the type column and values.
        column_names.map{ |col| string_single_value(row, col) }.join(", ")
      end

      # This functions calls the necessary functions to create a complete
      # sqlite3 query to multiple insertion. The methods are in the Abstract
      # Query module. If some method is too specific to this database adapter
      # you can overwrite it. The values that the user gave will be treated
      # in batches of 500 items because sqlite database allows by default
      # batches of 500.and each batch will generate a query. This method will
      # generate an array with batch queries.
      def execute
        @values.each_slice(MAX_VALUES_PER_INSERTION).map do |slice|
          @values = slice
          "#{begin_string}#{string_columns}#{string_values}"
        end
      end

    end
  end
end
