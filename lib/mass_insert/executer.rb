module MassInsert
  class Executer
    def execute(queries)
      Array(queries).each do |query|
        ActiveRecord::Base.connection.execute(query)
      end
    end
  end
end
