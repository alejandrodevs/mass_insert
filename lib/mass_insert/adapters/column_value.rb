module MassInsert
  module Adapters
    class ColumnValue

      attr_accessor :row, :column, :options

      def initialize row, column, options
        @row     = row
        @column  = column
        @options = options
      end

      # Returns the class that invokes the mass insert process. The class
      # is in the options hash.
      def class_name
        options[:class_name]
      end

      # Returns a symbol with the column type in the database. The column or
      # attribute should belongs to the class that invokes the mass insert.
      def column_type
        class_name.columns_hash[@column.to_s].type
      end

      # Returns the value to this column in the row hash. The value is
      # finding by symbol or string key to be most flexible.
      def column_value
        row[column.to_sym] || row[column.to_s]
      end

      # Returns the string with the database adapter name usually in the
      # database.yml file in your Rails project.
      def adapter
        ActiveRecord::Base.connection.instance_values["config"][:adapter]
      end

      # Returns a single column string value with the correct format and
      # according to the database configuration, column type and presence.
      def build
        case column_type
        when :string, :text, :date, :datetime, :time, :timestamp
          column_value ? "'#{column_value}'" : "null"
        when :integer
          column_value ? column_value.to_i.to_s : "null"
        when :decimal, :float
          column_value ? column_value.to_f.to_s : "null"
        when :binary
          column_value ? 1 : 0
        when :boolean
          case adapter
          when "mysql2", "postgresql", "sqlserver"
            column_value ? "true" : "false"
          when "sqlite3"
            column_value ? "0" : "1"
          end
        end
      end

    end
  end
end
