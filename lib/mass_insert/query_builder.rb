module MassInsert
  class QueryBuilder

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    def class_name
      options[:class_name]
    end

    def table_name
      options[:class_name].table_name
    end

    def table_columns
      table_name.column_defaults.keys
    end

    def column_type column
      class_name.columns_hash[column.to_s].type
    end

    def adapter
      ActiveRecord::Base.connection.instance_values["config"][:adapter]
    end

    def execute

    end

  end
end
