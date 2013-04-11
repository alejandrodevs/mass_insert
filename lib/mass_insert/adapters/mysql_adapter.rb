module MassInsert
  module Adapters
    class MysqlAdapter < Adapter

      # Returns a begin string to a basic mysql query insertion. Include
      # the class table_name and it's included in the string.
      def begin_string
        "INSERT INTO #{table_name} "
      end

      # Returns a string  with the column names to the class table name
      # and divided by commmas.
      def string_columns
        "(#{column_names.join(", ")}) "
      end

      # Returns the string with all the row values that will be included
      # in the sql string.
      def string_values
        "VALUES (#{string_rows_values})"
      end

      # Gives the correct format to the values string to all rows. This
      # functions calls a function that will generate a single string row
      # and at the end all the strings are concatenated.
      def string_rows_values
        values.map{ |row| string_single_row_values(row) }.join("), (")
      end

      def string_single_row_values row
        # Prepare the single row to be included in the sql string.
        # Sanitizes keys and values or includes others.
        sanitize_row_values(row)

        # Generates the values to this row that will be included according
        # to the type column and values.
        column_names.map{ |col| string_single_value(row, col) }.join(", ")
      end

      # Returns a single column string value with the correct format and
      # according to the database configuration, column type and presence.
      def string_single_value row, column
        case column_type(column)
        when :string, :text, :date, :datetime, :time, :timestamp
          row[column] ? "'#{row[column]}'" : "''"
        when :integer
          row[column].to_i.to_s
        when :decimal, :float
          row[column].to_f.to_s
        when :boolean, :binary
          row[column] ? 1 : 0
        end
      end

      # This functions calls the necessary functions to create a complete
      # mysql query to multiple insertion.
      def execute
        begin_string << string_columns << string_values
      end

    end
  end
end
