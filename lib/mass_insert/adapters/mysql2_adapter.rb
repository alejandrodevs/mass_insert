module MassInsert
  module Adapters
    class Mysql2Adapter < AbstractAdapter
      def to_sql
        "#{insert_sql} #{values_sql} #{on_duplicate_key_update};"
      end

      def on_duplicate_key_update
        if @options[:handle_duplication]
          "ON DUPLICATE KEY UPDATE #{quoted_columns.map { |quoted_column| "#{quoted_column}=#{quoted_column}" }.join(',')}"
        end
      end
    end
  end
end
