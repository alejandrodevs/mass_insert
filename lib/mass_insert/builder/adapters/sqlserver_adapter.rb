module MassInsert
  module Builder
    module Adapters
      class SQLServerAdapter < Adapter

        VALUES_PER_INSERTION = 1000

        # The method is overwrited because the timestamp format to SQLServer
        # adapter needs accuracy with three nanoseconds.
        def timestamp_format
          "%Y-%m-%d %H:%M:%S.%3N"
        end

        # Values will be treated in batches of 1000 items because its a standard
        # in SQL server. It'll generate an array with queries.
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
