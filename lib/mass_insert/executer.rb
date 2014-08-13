module MassInsert
  class Executer
    def execute(query)
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute(query)
      end
    end
  end
end
