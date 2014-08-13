module MassInsert
  class Builder
    def build(values, options)
      Utilities.adapter_class.new(values, options).execute
    end
  end
end
