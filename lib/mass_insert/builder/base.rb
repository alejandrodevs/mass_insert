module MassInsert
  module Builder
    class Base
      ADAPTERS = {
        mysql2:     Adapters::Mysql2Adapter,
        postgresql: Adapters::PostgreSQLAdapter,
        sqlite3:    Adapters::SQLite3Adapter,
        sqlserver:  Adapters::SQLServerAdapter
      }

      # This function gets the database adapter class and returns the
      # sql string ready to be executed.
      def build(values, options)
        adapter_class.new(values, options).execute
      end

      private

      def adapter_class
        ADAPTERS[Utilities.adapter.to_sym]
      end
    end
  end
end
