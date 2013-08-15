module MassInsert
  module Builder
    module Adapters
      autoload :Adapter,            'mass_insert/builder/adapters/adapter.rb'
      autoload :Mysql2Adapter,      'mass_insert/builder/adapters/mysql2_adapter.rb'
      autoload :PostgreSQLAdapter,  'mass_insert/builder/adapters/postgresql_adapter.rb'
      autoload :SQLite3Adapter,     'mass_insert/builder/adapters/sqlite3_adapter.rb'
      autoload :SQLServerAdapter,   'mass_insert/builder/adapters/sqlserver_adapter.rb'

      module Helpers
        autoload :AbstractQuery,    'mass_insert/builder/adapters/helpers/abstract_query.rb'
        autoload :ColumnValue,      'mass_insert/builder/adapters/helpers/column_value.rb'
      end
    end
  end
end
