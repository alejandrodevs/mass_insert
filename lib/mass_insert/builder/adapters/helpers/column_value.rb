module MassInsert
  module Builder
    module Adapters
      module Helpers
        class ColumnValue

          attr_accessor :row, :column, :class_name

          def initialize row, column, class_name
            @row        = row
            @column     = column
            @class_name = class_name
          end

          # Returns a symbol with the column type according to the database.
          def column_type
            class_name.columns_hash[@column.to_s].type
          end

          # Returns the value to this column in the row hash. The value is
          # finding by symbol or string key to be most flexible.
          def column_value
            row.fetch(column){row[@column.to_s]}
          end

          # Returns the default column value and it's added to the query if
          # the row hash does not contains column value.
          def default_value
            default_db_value ? default_db_value.to_s : "null"
          end

          # Returns the default database column value using methods that
          # ActiveRecord provides.
          def default_db_value
            class_name.columns_hash[@column.to_s].default
          end

          # Returns the valid column value to be included in the query.
          # The value depends of the database engine.
          def build
            column_value.nil? ? default_value : send(:"column_value_#{column_type}")
          end

          # Returns the correct value when column value is string, text,
          # date, time, datetime, timestamp.
          def column_value_string
            "'#{column_value}'"
          end
          alias :column_value_text      :column_value_string
          alias :column_value_date      :column_value_string
          alias :column_value_time      :column_value_string
          alias :column_value_datetime  :column_value_string
          alias :column_value_timestamp :column_value_string
          alias :column_value_binary    :column_value_string

          # Returns the correct value to integer column.
          def column_value_integer
            column_value.to_i.to_s
          end

          # Returns the correct value to decimal or float column.
          def column_value_decimal
            column_value.to_f.to_s
          end
          alias :column_value_float :column_value_decimal

          # Returns the correct value to boolean column. This column calls
          # the correct method according to the database adapter.
          def column_value_boolean
            self.send(:"#{Utilities.adapter}_column_value_boolean")
          end

          # Returns the column value to boolean column to mysql, postgresql
          # and sqlserver databases.
          def mysql2_column_value_boolean
            column_value ? "true" : "false"
          end
          alias :postgresql_column_value_boolean :mysql2_column_value_boolean
          alias :sqlserver_column_value_boolean  :mysql2_column_value_boolean

          # Returns the column value to boolean column to sqlite database.
          def sqlite3_column_value_boolean
            column_value ? "1" : "0"
          end

        end
      end
    end
  end
end
