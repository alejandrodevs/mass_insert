module MassInsert
  module Adapters
    module Helpers
      module AbstractQuery

        # Returns a begin string to a basic mysql query insertion. Include
        # the class table_name and it's included in the string.
        def begin_string
          "INSERT INTO #{table_name} "
        end

        # Returns a string  with the column names to the class table name
        # and divided by commas.
        def string_columns
          "(#{column_names.join(", ")}) "
        end

        # Returns the string with all the row values that will be included
        # in the sql string.
        def string_values
          "VALUES (#{string_rows_values});"
        end

        # Gives the correct format to the values string to all rows. This
        # functions calls a function that will generate a single string row
        # and at the end all the strings are concatenated.
        def string_rows_values
          values.map{ |row| string_single_row_values(row) }.join("), (")
        end

        # Returns the row column values string to be added in query string
        # according to the type column and values.
        # Before that row is prepared with the correct values.
        def string_single_row_values row
          row.merge!(timestamp_values) if timestamp?
          column_names.map{ |col| string_single_value(row, col) }.join(", ")
        end

        # Returns a single column string value with the correct format and
        # according to the database configuration, column type and presence.
        def string_single_value row, column
          ColumnValue.new(row, column, options[:class_name]).build
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
end
