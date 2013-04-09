module MassInsert
  # This class provides some helper methods to build the query string that
  # be executed. The methods here provides a functionality that be required
  # in all the adapters.
  #
  # This class will be inherit in all adapter types classes.
  class Adapter

    attr_accessor :values, :options, :columns

    def initialize values, options
      @values  = values
      @options = options

      # Prepare the columns according to the options.
      sanitize_columns
    end

    # Returns the class like a constant that invokes the mass insert.
    # Should be a class that inherits from ActiveRecord::Base.
    def class_name
      options[:class_name]
    end

    # Returns a string with the database table name where  all the records
    # will be saved.
    def table_name
      options[:table_name]
    end

    # Returns an array with all the column names in a class_name.
    # Returns an array like this...
    #
    #   ["name", "email", "password", "created_at"]
    #
    # Include all the columns names without exception.
    def table_columns
      class_name.column_names
    end

    # Returns an array with the column names to teh class name, but
    # This array can be modified according to the options.
    def columns
      @columns ||= table_columns.sort
    end

    # Update the array with the columns names according to the options
    # and prepare the columns array with only valid columns.
    def sanitize_columns
      sanitize_primary_key_column
    end

    # Prepare the primary key column according to primary key options.
    def sanitize_primary_key_column
      if options[:primary_key_mode] == "automatic"
        columns.delete(options[:primary_key])
      end
    end

    # Returns a symbol with the column type in the database. The column or
    # attribute should belongs to the class that invokes the mass insert.
    def column_type column
      class_name.columns_hash[column.to_s].type
    end

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
