module MassInsert
  module Adapters
    class Adapter
      include Helpers::AbstractQuery
      include Helpers::Timestamp
      include Helpers::Sanitizer

      attr_accessor :values, :options, :columns

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

      # Returns the array with the column names valid to be included into the
      # query string according to the options.
      def columns
        @columns ||= sanitized_columns
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
