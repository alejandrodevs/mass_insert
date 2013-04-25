module MassInsert
  module Adapters
    module Helpers
      module Sanitizer

        # Returns an array with the column names in the database table like
        # a symbols.
        def table_columns
          class_name.column_names.map(&:to_sym)
        end

        # Update the array with the columns names according to the options
        # and prepare the columns array with only valid columns.
        def sanitized_columns
          columns = table_columns
          columns.delete(primary_key) if primary_key_mode == :auto
          columns
        end

      end
    end
  end
end
