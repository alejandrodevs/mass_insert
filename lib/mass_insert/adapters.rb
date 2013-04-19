module MassInsert
  module Adapters
    autoload :Adapter,            'mass_insert/adapters/adapter.rb'
    autoload :AbstractQuery,      'mass_insert/adapters/abstract_query.rb'
    autoload :ColumnValue,        'mass_insert/adapters/column_value.rb'
    autoload :Helpers,            'mass_insert/adapters/helpers.rb'
    autoload :Mysql2Adapter,      'mass_insert/adapters/mysql2_adapter.rb'
    autoload :PostgreSQLAdapter,  'mass_insert/adapters/postgresql_adapter.rb'
    autoload :SQLite3Adapter,     'mass_insert/adapters/sqlite3_adapter.rb'
    autoload :SQLServerAdapter,   'mass_insert/adapters/sqlserver_adapter.rb'
  end
end
