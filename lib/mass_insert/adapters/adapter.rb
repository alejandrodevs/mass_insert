module MassInsert
  module Adapters
    # This class provides some helper methods to build the sql string that
    # be executed. The methods here provides a functionality that be required
    # in all the adapters.
    class Adapter
      include Helpers::Timestamp
      include Helpers::Sanitizer

      attr_accessor :values, :options, :column_names

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

      # Returns a string with the database table name where all the records
      # will be saved.
      def table_name
        options[:table_name]
      end

      # Returns an array with the column names to the database table,
      # but this array can be modified according to the options.
      def column_names
        @column_names ||= class_name.column_names
      end

      # Returns a symbol with the column type in the database. The column or
      # attribute should belongs to the class that invokes the mass insert.
      def column_type column
        class_name.columns_hash[column.to_s].type
      end

    end
  end
end
