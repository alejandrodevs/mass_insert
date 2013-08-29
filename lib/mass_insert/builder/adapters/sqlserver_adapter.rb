module MassInsert
  module Builder
    module Adapters
      class SQLServerAdapter < Adapter

        # Returns a basic part of the query with the columns definition.
        def string_columns
          "([#{columns.join("], [")}]) "
        end

        # Returns the amount of records to each query. Tries to take the
        # each_slice option value or 1000 due it's a standard in SQLServer.
        def values_per_insertion
          each_slice || 1000
        end

        # The method is overwrited because the timestamp format to SQLServer
        # adapter needs accuracy with three nanoseconds.
        def timestamp_format
          "%Y-%m-%d %H:%M:%S.%3N"
        end

      end
    end
  end
end
