module MassInsert
  module Builder
    class Base

      # This function gets the correct adapter class and returns the
      # sql string ready to be executed.
      def build values, options
        adapter_class.new(values, options).execute
      end

      # Returns the class of the correct database adapter according to the
      # database engine that is used in Rails project.
      def adapter_class
        case Utilities.adapter
        when "mysql2"
          Adapters::Mysql2Adapter
        when "postgresql"
          Adapters::PostgreSQLAdapter
        when "sqlite3"
          Adapters::SQLite3Adapter
        when "sqlserver"
          Adapters::SQLServerAdapter
        end
      end

    end
  end
end
