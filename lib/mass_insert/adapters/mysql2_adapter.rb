module MassInsert
  module Adapters
    class Mysql2Adapter < Adapter

      # This method is overwrite because the timestamp format to this
      # database engine does not need precision in nanoseconds.
      def timestamp_format
        "%Y-%m-%d %H:%M:%S"
      end

    end
  end
end
