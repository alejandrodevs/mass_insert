module MassInsert
  class Builder
    def build(values, options)
      Utilities.adapter_class.new(values, options).to_sql
    end
  end
end
