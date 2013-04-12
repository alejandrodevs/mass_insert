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

        # Returns the timestamp values to be merge into row values that
        # will be saved in the database.
        def timestamp_values
          {
            :created_at => Time.now.to_s,
            :updated_at => Time.now.to_s
          }
        end

      end
    end
  end
end
