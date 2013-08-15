module MassInsert
  module Builder
    module Adapters
      class Mysql2Adapter < Adapter

        # The method is overwrited because the timestamp format to mysql
        # adapter does not need accuracy with nanoseconds.
        def timestamp_format
          "%Y-%m-%d %H:%M:%S"
        end

      end
    end
  end
end
