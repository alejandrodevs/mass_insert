module MassInsert
  module Adapters
    module AdapterHelpers
      module Timestamp

        # Returns true o false if the database table has the
        # timestamp columns.
        def timestamp?
          columns.include?(:created_at) && columns.include?(:updated_at)
        end

        # Returns timestamp format according to the database adapter. This
        # function can be overwrite in database adapters classes to put the
        # correct format to that database.
        def timestamp_format
          "%Y-%m-%d %H:%M:%S.%6N"
        end

        # Returns the timestamp value with specific format according to the
        # correct timestamp format to that database.
        def timestamp
          Time.now.strftime(timestamp_format)
        end

        # Returns the timestamp values to be merge into row values that
        # will be saved in the database.
        def timestamp_values
          {:created_at => timestamp, :updated_at => timestamp}
        end

      end
    end
  end
end
