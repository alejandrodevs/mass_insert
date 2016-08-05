module MassInsert
  module Adapters
    class Mysql2Adapter < AbstractAdapter
      def to_sql
        "#{insert_sql} #{values_sql} #{on_duplicate_key_update};"
      end

      def on_duplicate_key_update
        if @options[:handle_duplication]
          "ON DUPLICATE KEY UPDATE #{on_duplicate_key_update_values}"
        end
      end

      def on_duplicate_key_update_values
        quoted_columns.map do |quoted_column|
          "#{quoted_column}=#{quoted_column}"
        end.join(',')
      end
    end
  end
end
