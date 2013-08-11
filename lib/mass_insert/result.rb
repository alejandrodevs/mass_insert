module MassInsert
  class Result

    def initialize process
      @process = process
    end

    def building_time
      @process.instance_variable_get(:@building_time)
    end

    def execution_time
      @process.instance_variable_get(:@execution_time)
    end

    def time
      building_time + execution_time
    end

    def records
      @process.instance_variable_get(:@values).count
    end

  end
end
