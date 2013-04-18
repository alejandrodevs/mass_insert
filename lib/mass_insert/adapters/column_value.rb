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

      # Returns the default value string to be included in query string.
      # This default value is added to the query if the row hash does not
      # contains the database column value.
      def default_value
        default_db_value ? default_db_value.to_s : "null"
      end

      # Return the database default value using methods that ActiveRecord
      # provides to see database columns settings.
      def default_db_value
        class_name.columns_hash[@column.to_s].default
      end

      # Returns a single column string value with the correct format and
      # according to the database configuration, column type and presence.
      def build
        self.send "column_value_#{column_type}".to_sym
      end

      # Returns the correct value when the column value is string, text,
      # date, time, datetime, timestamp. There are alias method to the
      # other column types that need a similar query value.
      def column_value_string
        column_value.nil? ? default_value : "'#{column_value}'"
      end
      alias :column_value_text      :column_value_string
      alias :column_value_date      :column_value_string
      alias :column_value_time      :column_value_string
      alias :column_value_datetime  :column_value_string
      alias :column_value_timestamp :column_value_string

      # Returns the correct value to column value is integer. If the row
      # hash does not include the value to this column return the default
      # value according to database configuration.
      def column_value_integer
        column_value.nil? ? default_value : column_value.to_i.to_s
      end

      # Returns the correct value to column value is decimal. There is an
      # alias method to float type. If the row hash does not include the
      # value to this column return the default value according to database
      # configuration.
      def column_value_decimal
        column_value.nil? ? default_value : column_value.to_f.to_s
      end
      alias :column_value_float :column_value_decimal

      # Returns the correct value to column value is binary. If the row
      # hash does not include the value to this column return the default
      # value according to database configuration.
      def column_value_binary
        case adapter
        when "mysql2", "sqlite3", "sqlserver"
          column_value.nil? ? default_value : "1"
        when "postgresql"
          column_value.nil? ? default_value : "'\x74'"
        end
      end

      # Returns the correct value to column value is boolean. If the row
      # hash does not include the value to this column return the default
      # value according to database configuration.
      def column_value_boolean
        case adapter
        when "mysql2", "postgresql", "sqlserver"
          column_value.nil? ? default_value : "true"
        when "sqlite3"
          column_value.nil? ? default_value : "1"
        end
      end

    end
  end
end
