module MassInsert
  module Adapters
    class Mysql < MassInsert::QueryBuilder

      def begin_of_string
        "INSERT INTO #{table_name} "
      end

      def string_columns
        "('#{table_columns.join("', '")}') "
      end

      def string_values
        "VALUES ((#{string_rows_values}))"
      end

      def string_rows_values
        values.map{ |raw| string_single_row_values(raw) }.join("), (")
      end

      def string_single_row_values raw
        table_columns.map{ |col| string_single_value(raw, col) }.join(", ")
      end

      def string_single_value raw, column
        case column_type(column)
        when :string, :text, :date, :datetime, :time, :timestamp
          raw[column] ? "'#{raw[column]}'" : "''"
        when :integer, :float, :decimal, :boolean, :binary
          raw[column].to_s
        end
      end

      def execute
        begin_of_string << string_columns << string_values
      end

    end
  end
end
