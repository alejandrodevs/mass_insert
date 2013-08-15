module MassInsert
  module Builder
    module Adapters
      class SQLite3Adapter < Adapter

        VALUES_PER_INSERTION = 500

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

        # Values will be treated in batches of 500 items because its a standard
        # in sqlite. It'll generate an array with queries.
        def execute
          @values.each_slice(VALUES_PER_INSERTION).map do |slice|
            @values = slice
            super
          end
        end

      end
    end
  end
end
