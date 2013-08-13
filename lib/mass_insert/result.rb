module MassInsert
  # This class is responsible to provides the mass insert process
  # results according to the Process class instance.
  class Result

    def initialize process
      @process = process
    end

    # Returns the time that took to create the query or queries 
    # string that was persisted.
    def building_time
      @process.instance_variable_get(:@building_time).total
    end

    # Returns the time that took to execute the query or queries
    # string that was persisted.
    def execution_time
      @process.instance_variable_get(:@execution_time).total
    end

    # Returns the time that took to do all the MassInsert process.
    def time
      building_time + execution_time
    end

    # Returns the amount of records that were persisted.
    def records
      @process.instance_variable_get(:@values).count
    end

  end
end
