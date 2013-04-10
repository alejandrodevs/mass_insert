module MassInsert
  module Adapters
    class MysqlAdapter < Adapter

      def begin_of_string
        "INSERT INTO #{table_name} "
      end

      def string_columns
        "(#{column_names.join(", ")}) "
      end

      def string_values
        "VALUES (#{string_rows_values})"
      end

      def string_rows_values
        values.map{ |row| string_single_row_values(row) }.join("), (")
      end

      def string_single_row_values row
        sanitize_row_values(row)
        column_names.map{ |col| string_single_value(row, col) }.join(", ")
      end

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

      def execute
        begin_of_string << string_columns << string_values
      end

    end
  end
end
