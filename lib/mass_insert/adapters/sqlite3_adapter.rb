module MassInsert
  module Adapters
    class Sqlite3Adapter < Adapter

      attr_accessor :counter_id

      # This method is overwrite because the query string to the Sqlite3
      # adapter is different. Then the method in the AbstractQuery module
      # is ignored.
      def string_values
        "SELECT #{string_rows_values}"
      end

      # This method is overwrite because the query string to complete the
      # string rows values is different. The separator to sqlite adapter is
      # 'UNION SELECT' instead of '), (' in other sql adapters.
      def string_rows_values
        values.map{ |row| string_single_row_values(row) }.join(" UNION SELECT ")
      end

      # This method is overwrite and when is called by columns_name method
      # ignore the method that is in the Sanitizer module. It's over write
      # because the Sqlite3 adapter require other rules in its columns.
      def sanitized_columns
        table_columns
      end

      def string_single_row_values row
        # Prepare the single row to be included in the sql string.
        @counter_id = counter_id + 1
        row.merge!(primary_key => counter_id)
        row.merge!(timestamp_values) if timestamp?

        # Generates the values to this row that will be included according
        # to the type column and values.
        column_names.map{ |col| string_single_value(row, col) }.join(", ")
      end

      def counter_id
        @counter_id ||= class_name.last.id rescue 0
      end

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
