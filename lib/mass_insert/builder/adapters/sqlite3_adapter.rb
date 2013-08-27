module MassInsert
  module Builder
    module Adapters
      class SQLite3Adapter < Adapter

        # Returns the amount of records to each query. Tries to take the
        # each_slice option value or 500 due it's a standard in SQLite.
        def values_per_insertion
          each_slice || 500
        end

        # The method is overwrited because the queries structure to Sqlite3
        # adapter are different.
        def string_values
          "SELECT #{string_rows_values};"
        end

        # The method is overwrited because the record separator to sqlite adapter
        # is different.
        def string_rows_values
          values.map{ |row| string_single_row_values(row) }.join(" UNION SELECT ")
        end

      end
    end
  end
end
