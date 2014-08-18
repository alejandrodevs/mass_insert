module MassInsert
  module Adapters
    class SQLite3Adapter < AbstractAdapter
      def insert_sql
        "INSERT INTO #{quoted_table_name} #{columns_sql} SELECT"
      end

      def values_sql
        "(#{array_of_attributes_sql.join(' UNION SELECT ')});"
      end
    end
  end
end
