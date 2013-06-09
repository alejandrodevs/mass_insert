module MassInsert
  module Adapters
    class Adapter
      include AdapterHelpers

      attr_accessor :values, :options, :columns

      def initialize values, options
        @values  = values
        @options = options
      end

      # Returns the options according to the method that wasn't found.
      def method_missing method, *args
        @options.has_key?(method) ? @options[method] : super
      end

      # Returns the array with the column names valid to be included into
      # the query string according to the options.
      def columns
        @columns ||= sanitized_columns
      end

    end
  end
end
