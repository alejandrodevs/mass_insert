module MassInsert
  module Builder
    module Adapters
      module AdapterHelpers
        module Sanitizer

          # Returns an array with the columns in the table like symbols.
          def table_columns
            class_name.column_names.map(&:to_sym)
          end

          # Prepare array with the column names according to the options.
          def sanitized_columns
            columns = table_columns
            columns.delete(primary_key) if primary_key_mode == :auto
            columns
          end

        end
      end
    end
  end
end
