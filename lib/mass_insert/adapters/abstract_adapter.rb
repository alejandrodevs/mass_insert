module MassInsert
  module Adapters
    class AbstractAdapter < SimpleDelegator
      attr_accessor :values, :options

      def initialize(values, options)
        super(options.fetch(:class_name))
        @values  = values
        @options = options
      end

      def to_sql
        "#{insert_sql} #{values_sql};"
      end

      private

      def columns
        @columns ||= begin
          columns = column_names
          columns.delete(primary_key) unless options[:primary_key]
          columns.map(&:to_sym)
        end
      end

      def quoted_columns
        columns.map do |name|
          connection.quote_column_name(name)
        end
      end

      def insert_sql
        "INSERT INTO #{quoted_table_name} #{columns_sql} VALUES"
      end

      def columns_sql
        "(#{quoted_columns.join(',')})"
      end

      def values_sql
        "(#{array_of_attributes_sql.join('),(')})"
      end

      def array_of_attributes_sql
        values.map do |attrs|
          columns.map do |name|
            value = column_value(attrs, name)
            connection.quote(value)
          end.join(',')
        end
      end

      def column_value(attrs, column)
        attrs.fetch(column.to_sym) do
          attrs.fetch(column.to_s, nil)
        end
      end
    end
  end
end
