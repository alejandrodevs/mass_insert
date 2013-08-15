module MassInsert
  module Builder
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

        # Returns an array according to the options with the column names
        # that will be included in the queries.
        def columns
          @columns ||= sanitized_columns
        end

      end
    end
  end
end
