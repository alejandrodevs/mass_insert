module MassInsert
  module Adapters
    module Helpers
      module Timestamp

        # Returns true o false if the database table has the timestamp
        # columns.
        def timestamp?
          columns.include?("created_at") && columns.include?("updated_at")
        end

        def set_timestamps_columns raw
          raw.merge!({
            :created_at => Time.now.to_s,
            :updated_at => Time.now.to_s
          })
        end

      end
    end
  end
end
