module MassInsert
  class Execution

    attr_accessor :values, :options

    def initialize values, options
      @values  = values
      @options = options
    end

    # Saves the sql string into database. Use the helper that
    # ActiveRecord  provides.
    #
    #   ActiveRecord::Base.connection.execute(sql_string)
    def execute sql
      ActiveRecord::Base.connection.execute(sql)
    end

    # This function is called from Base module and starts the mass
    # database insertion.
    def start
      execute(generate_sql)
    end

    # This function calls the correct adapter class and returns the sql
    # string ready to be executed.
    def generate_sql
      adapter_instance_class.execute
    end

    # Returns a string that contains the adapter type previosly
    # configured in Rails project.
    def adapter
      ActiveRecord::Base.connection.instance_values["config"][:adapter]
    end

    # Returns an instance of the correct database adapter and this
    # instance will be called to generate the sql string.
    def adapter_instance_class
      case adapter
      when "mysql", "mysql2"
        MassInsert::Adapters::Mysql.new(values, options)
      end
    end

  end
end

Dir[File.dirname(__FILE__) + "/adapters/*.rb"].each { |file| require file }
