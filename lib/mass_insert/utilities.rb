module MassInsert
  class Utilities
    ADAPTERS = {
      mysql2:     Adapters::Mysql2Adapter,
      postgresql: Adapters::PostgreSQLAdapter,
      sqlite3:    Adapters::SQLite3Adapter,
      sqlserver:  Adapters::SQLServerAdapter
    }

    def self.adapter
      database_config[:adapter].to_sym
    end

    def self.database_config
      ActiveRecord::Base.connection.instance_values['config']
    end

    def self.adapter_class
      ADAPTERS[Utilities.adapter]
    end

    def self.per_batch
      500
    end
  end
end
