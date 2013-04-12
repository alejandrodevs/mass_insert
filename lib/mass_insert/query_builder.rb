module MassInsert
  class QueryBuilder

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    # This function calls the correct adapter class and returns the
    # sql string ready to be executed and returns it to be execute in
    # the QueryExecution class.
    def build
      adapter_instance_class.execute
    end

    # Returns a string that contains the adapter type previosly
    # configured in Rails project usually in the database.yml file.
    def adapter
      ActiveRecord::Base.connection.instance_values["config"][:adapter]
    end

    # Returns an instance of the correct database adapter and this
    # instance will be called to generate the sql string. The values
    # and options are passed by params when the correct adapter class
    # is instanced.
    def adapter_instance_class
      case adapter
      when "mysql", "mysql2"
        Adapters::MysqlAdapter.new(values, options)
      end
    end

  end
end
