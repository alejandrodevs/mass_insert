module MassInsert
  module Timestamp

    # Returns true o false if the database table has the timestamp columns.
    def timestamp?
      columns.include?("created_at") && columns.include?("updated_at")
    end

    def set_timestamps_columns raw
      if timestamp?
        raw.merge!({
          :created_at => Time.now.to_s(:db),
          :updated_at => Time.now.to_s(:db),
        })
      end
    end

  end
end
