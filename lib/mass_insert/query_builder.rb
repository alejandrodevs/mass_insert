module MassInsert
  module QueryBuilder

    def table_name
      options[:table_name]
    end

    def class_name
      options[:class_name]
    end

    def adapter
      ActiveRecord::Base.connection.instance_values["config"][:adapter]
    end

    def generate_query

    end

  end
end
