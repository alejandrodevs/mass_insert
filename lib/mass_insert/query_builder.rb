module MassInsert
  class QueryBuilder

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    # Returns the class like a constant that invokes the mass insert.
    def class_name
      options[:class_name]
    end

    # Returns the name of the database table where the the record
    # will be saved.
    def table_name
      options[:table_name]
    end

    # Returns an array with all the column names in a class_name.
    # Returns an array like this...
    #
    #   ["id", "name", "email", "password", "created_at"]
    #
    def table_columns
      class_name.column_defaults.keys
    end

    # Returns a symbol with the column type in the database.
    def column_type column
      class_name.columns_hash[column.to_s].type
    end

    # Returns a string that contains the adapter type previosly
    # configured in Rails project.
    def adapter
      ActiveRecord::Base.connection.instance_values["config"][:adapter]
    end

    # Builds the sql string that will be execute into the database.
    # The sql string depends of the database adapter.
    def build
      adapter_instance_class.execute
    end

    # Returns an instance of the correct database adapter and this
    # instance will be called to generate the sql string.
    def adapter_instance_class
      case adapter
      when "mysql"
        MassInsert::Adapters::Mysql.new
      end
    end

  end
end
