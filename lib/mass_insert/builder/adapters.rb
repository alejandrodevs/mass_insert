module MassInsert
  module Builder
    module Adapters
      autoload :Adapter,            'mass_insert/builder/adapters/adapter.rb'
      autoload :AdapterHelpers,     'mass_insert/builder/adapters/adapter_helpers.rb'
      autoload :Mysql2Adapter,      'mass_insert/builder/adapters/mysql2_adapter.rb'
      autoload :PostgreSQLAdapter,  'mass_insert/builder/adapters/postgresql_adapter.rb'
      autoload :SQLite3Adapter,     'mass_insert/builder/adapters/sqlite3_adapter.rb'
      autoload :SQLServerAdapter,   'mass_insert/builder/adapters/sqlserver_adapter.rb'
    end
  end
end
