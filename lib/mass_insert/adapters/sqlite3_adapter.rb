module MassInsert
  module Adapters
    class SQLite3Adapter < Adapter
      def string_values
        "SELECT #{string_rows_values};"
      end

      def string_rows_values
        values.map { |row| string_single_row_values(row) }.join(' UNION SELECT ')
      end
    end
  end
end
