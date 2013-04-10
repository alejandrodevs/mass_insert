module MassInsert
  module Adapters
    module Helpers
      module Sanitizer

        # Update the array with the columns names according to the options
        # and prepare the columns array with only valid columns.
        def sanitize_columns
          sanitize_primary_key_column
        end

        # Prepare the primary key column according to primary key options.
        def sanitize_primary_key_column
          if options[:primary_key_mode] == "automatic"
            column_names.delete(options[:primary_key])
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
