module MassInsert
  module Builder
    module Adapters
      module Helpers
        module AbstractQuery

          # Returns a basic beginning of the query.
          def begin_string
            "INSERT INTO #{class_name.table_name} "
          end

          # Returns a basic part of the query with the columns definition.
          def string_columns
            "(#{columns.join(", ")}) "
          end

          # Returns a basic part of the query with all the records values.
          def string_values
            "VALUES (#{string_rows_values});"
          end

          # Returns all the column values to all the records
          def string_rows_values
            values.map{ |row| string_single_row_values(row) }.join("), (")
          end

          # Returns all the column values to a single record.
          def string_single_row_values row
            row.merge!(timestamp_hash) if timestamp?
            columns.map{ |col| string_single_value(row, col) }.join(", ")
          end

          # Returns a single column value. According to the database
          # configuration, column type and presence.
          def string_single_value row, column
            ColumnValue.new(row, column, class_name).build
          end

          # Calls the necessary methods to create a complete basic query.
          def execute
            "#{begin_string}#{string_columns}#{string_values}"
          end

        end
      end
    end
  end
end
