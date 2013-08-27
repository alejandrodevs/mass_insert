module MassInsertSupport

  def adapters_supported
    {
      "mysql2"      => "Mysql2Adapter",
      "postgresql"  => "PostgreSQLAdapter",
      "sqlite3"     => "SQLite3Adapter",
      "sqlserver"   => "SQLServerAdapter"
    }
  end

end
