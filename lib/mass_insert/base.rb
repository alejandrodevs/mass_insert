module MassInsert
  module Base
    def mass_insert(values, options = {})
      options[:class_name]  ||= self
      options[:each_slice]  ||= false
      options[:primary_key] ||= false

      Process.new(values, options).start
    end
  end
end
