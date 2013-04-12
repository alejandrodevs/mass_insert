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
          if primary_key_mode == :auto
            column_names.delete(primary_key)
          end
        end

      end
    end
  end
end
