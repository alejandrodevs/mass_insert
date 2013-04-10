module MassInsert
  module Adapters
    module Helpers
      module Timestamp

        # Returns true o false if the database table has the
        # timestamp columns.
        def timestamp?
          column_names.include?(:created_at) &&
            column_names.include?(:updated_at)
        end

        # Adds to the row hash the timestamp values that will
        # be saved in the database insertion.
        def set_timestamps_columns row
          row.merge!({
            :created_at => Time.now.to_s,
            :updated_at => Time.now.to_s
          })
        end

      end
    end
  end
end
