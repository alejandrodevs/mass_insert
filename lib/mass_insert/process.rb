module MassInsert
  class Process
    attr_reader :values, :options

    def initialize(values, options)
      @values  = values
      @options = options
    end

    def start
      ActiveRecord::Base.transaction do
        values.each_slice(per_batch).each do |batch|
          query = builder.build(batch, options)
          executer.execute(query)
        end
      end
    end

    private

    def builder
      @builder ||= Builder.new
    end

    def executer
      @executer ||= Executer.new
    end

    def per_batch
      options[:per_batch] || Utilities.per_batch
    end
  end
end
