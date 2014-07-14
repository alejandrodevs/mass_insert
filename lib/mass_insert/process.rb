module MassInsert
  class Process
    attr_reader :values, :options

    def initialize(values, options)
      @values  = values
      @options = options
    end

    def start
      queries = builder.build(values, options)
      executer.execute(queries)
    end

    private

    def builder
      Builder::Base.new
    end

    def executer
      Executer.new
    end
  end
end
