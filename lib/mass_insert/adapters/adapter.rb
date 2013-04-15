module MassInsert
  module Adapters
    # This class provides some helper methods to build the sql string that
    # be executed. The methods here provides a functionality that be required
    # in all the adapters.
    class Adapter
      include AbstractQuery
      include Helpers::Timestamp
      include Helpers::Sanitizer

      attr_accessor :values, :options, :column_names

      def initialize values, options
        @values  = values
        @options = options
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

      # Returns an array with the column names in the database table like
      # a symbols.
      def table_columns
        class_name.column_names.map(&:to_sym)
      end

      # Returns the array with the column names valid to be included into the
      # query string according to the options.
      def column_names
        @column_names ||= sanitized_columns
      end

      # Returns the primary_key column that was configured by the user.
      # Default primary_key it's id
      def primary_key
        options[:primary_key]
      end

      # Returns the primary key mode according to the user configuration.
      # Default primary key mode it's automatic.
      def primary_key_mode
        options[:primary_key_mode]
      end

    end
  end
end
