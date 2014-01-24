module MassInsert
  module Builder
    class Base
      ADAPTERS = { 
         'mysql2' => Adapters::Mysql2Adapter,
         'postgresql' => Adapters::PostgreSQLAdapter,
         'sqlite3' => Adapters::SQLite3Adapter,
         'sqlserver' => Adapters::SQLServerAdapter
      }
      # This function gets the correct adapter class and returns the
      # sql string ready to be executed.
      def build values, options
        adapter_class.new(values, options).execute
      end

      # Returns the class of the correct database adapter according to the
      # database engine that is used in Rails project.
      def adapter_class
        ADAPTERS[Utilities.adapter]
      end

    end
  end
end
