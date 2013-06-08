module MassInsert
  module Adapters
    module Helpers
      class ColumnValue

        attr_accessor :row, :column, :class_name

        def initialize row, column, class_name
          @row        = row
          @column     = column
          @class_name = class_name
        end

        # Returns a symbol with the column type in the database. The column or
        # attribute should belongs to the class that invokes the mass insert.
        def column_type
          class_name.columns_hash[@column.to_s].type
        end

        # Returns the value to this column in the row hash. The value is
        # finding by symbol or string key to be most flexible. This method
        # tries to get a value by symbol key with the column name first and
        # if the symbol key doesn't exist it will try to find it by string
        # key. Otherwise it will return nil.
        def column_value
          row.fetch(column){row[@column.to_s]}
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
        # If the row hash does not include the value to this column return the
        # default value according to database configuration.
        def build
          column_value.nil? ? default_value : send(:"column_value_#{column_type}")
        end

        # Returns the correct value when the column value is string, text,
        # date, time, datetime, timestamp. There are alias methods to the
        # other column types that need a similar query value.
        def column_value_string
          "'#{column_value}'"
        end
        alias :column_value_text      :column_value_string
        alias :column_value_date      :column_value_string
        alias :column_value_time      :column_value_string
        alias :column_value_datetime  :column_value_string
        alias :column_value_timestamp :column_value_string
        alias :column_value_binary    :column_value_string

        # Returns the correct value to integer column. The column values is
        # converted to integer to be sure that the value is correct to be
        # persisted into the database and after it, it's converted to string.
        def column_value_integer
          column_value.to_i.to_s
        end

        # Returns the correct value to decimal column. There is an alias method
        # to float type. The column values is converted to decimal to be sure
        # that the value is correct to be persisted into the database and after
        # it, it's converted to string.
        def column_value_decimal
          column_value.to_f.to_s
        end
        alias :column_value_float :column_value_decimal

        # Returns the correct value to boolean column. This column calls the
        # correct method according to the database adapter to return the correct
        # value to that database engine.
        def column_value_boolean
          self.send(:"#{adapter}_column_value_boolean")
        end

        # Returns the column value to boolean column like a string. If the
        # column value exists returns a true string else false string. There
        # are alias methods to the database engines that works similarity.
        def mysql2_column_value_boolean
          column_value ? "true" : "false"
        end
        alias :postgresql_column_value_boolean :mysql2_column_value_boolean
        alias :sqlserver_column_value_boolean  :mysql2_column_value_boolean

        # Returns the column value to boolean column like a string. If the
        # column value exists returns a "1" else "0".
        def sqlite3_column_value_boolean
          column_value ? "1" : "0"
        end

      end
    end
  end
end
