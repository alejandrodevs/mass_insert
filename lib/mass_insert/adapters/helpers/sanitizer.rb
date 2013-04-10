module MassInsert
  module Adapters
    module Helpers
      module Sanitizer

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

        # Update the array with the columns names according to the options
        # and prepare the columns array with only valid columns.
        def sanitize_columns
          sanitize_primary_key_column
        end

        # Prepare the primary key column according to primary key options.
        def sanitize_primary_key_column
          if primary_key_mode == :automatic
            column_names.delete(primary_key)
          end
        end

        # Prepares an individually row hash to be added to a sql string.
        # This method can be modified the row hash, adding or removing keys
        # or values.
        def sanitize_row_values row
          set_timestamps_columns(row) if timestamp?
        end

      end
    end
  end
end
