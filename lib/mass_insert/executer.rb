module MassInsert
  class Executer
    def execute(query)
      ActiveRecord::Base.connection.execute(query)
    end
  end
end
