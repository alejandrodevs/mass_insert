module MassInsert
  module Builder
    module Adapters
      module AdapterHelpers
        module Timestamp

          # Returns true o false if the database table has timestamp columns.
          def timestamp?
            columns.include?(:created_at) && columns.include?(:updated_at)
          end

          # Returns timestamp format according to the database adapter. This
          # function can be overwrite in database adapters classes.
          def timestamp_format
            "%Y-%m-%d %H:%M:%S.%6N"
          end

          # Returns the timestamp value according to the correct timestamp
          # format to that database engine.
          def timestamp
            Time.now.strftime(timestamp_format)
          end

          # Returns the timestamp hash to be merge into row values that will
          # be saved in the database.
          def timestamp_hash
            timestamp_value = timestamp
            {:created_at => timestamp_value, :updated_at => timestamp_value}
          end

        end
      end
    end
  end
end
