module MassInsert
  class QueryBuilder

    # This function gets the correct adapter class and returns the
    # sql string ready to be executed.
    def build values, options
      adapter_class.new(values, options).execute
    end

    # Returns a string that contains the adapter type previosly
    # configured in Rails project usually in the database.yml file.
    def adapter
      ActiveRecord::Base.connection.instance_values["config"][:adapter]
    end

    # Returns the class of the correct database adapter according to the
    # database engine that is used in Rails project.
    def adapter_class
      case adapter
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
