module MassInsert
  module Base

    # This method do a mass database insertion. Example...
    #
    #   User.mass_insert(values)
    #
    # The values should be an array with the object values
    # in a hash. Example...
    #
    #   [
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"}
    #   ]
    #
    # The id and timestamp attributes isn't required.
    #
    def mass_insert values, options = {}
      options[:class_name] = options[:class_name] || self

      execution = MassInsert::Execution.new(values, options)
      execution.start
    end

  end
end
