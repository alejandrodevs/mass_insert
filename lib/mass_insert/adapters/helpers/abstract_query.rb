module MassInsert
  module Adapters
    module Helpers
      module AbstractQuery
        def begin_string
          "INSERT INTO #{class_name.table_name} "
        end

        def string_columns
          "(#{columns.join(", ")}) "
        end

        def string_values
          "VALUES (#{string_rows_values});"
        end

        def string_rows_values
          values.map{ |row| string_single_row_values(row) }.join("), (")
        end

        def string_single_row_values row
          row.merge!(timestamp_hash) if timestamp?
          columns.map{ |col| string_single_value(row, col) }.join(", ")
        end

        def string_single_value row, column
          ColumnValue.new(row, column, class_name).build
        end

        def execute
          "#{begin_string}#{string_columns}#{string_values}"
        end
      end
    end
  end
end
