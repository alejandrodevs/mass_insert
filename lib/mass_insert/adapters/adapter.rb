module MassInsert
  module Adapters
    class Adapter
      include Helpers::AbstractQuery

      attr_accessor :values, :options

      def initialize values, options
        @values  = values
        @options = options
      end

      def columns
        @columns ||= begin
          columns = class_name.column_names
          columns.delete(class_name.primary_key)
          columns.map(&:to_sym)
        end
      end

      def timestamp?
        columns.include?(:created_at) && columns.include?(:updated_at)
      end

      def timestamp_hash
        { created_at: Time.now, updated_at: Time.now }
      end

      def class_name
        options[:class_name]
      end
    end
  end
end
