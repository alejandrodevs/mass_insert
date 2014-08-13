module MassInsert
  class Builder
    def build(values, options)
      class_name = options[:class_name]
      Utilities.adapter_class.new(class_name, values, options).to_sql
    end
  end
end
