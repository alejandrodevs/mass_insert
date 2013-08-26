module MassInsert
  module Base

    # = MassInsert
    #
    # Invoke mass insert just calling this from your ActiveRecord model...
    #
    #   User.mass_insert(values)
    #
    # The values should be an array of hashes. Include attributes and values
    # in every hash. Example...
    #
    #   values = [
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"}
    #   ]
    #
    # == Options
    #
    # MassInset gem allow you to send it options as second param. Example...
    #
    #   User.mass_insert(values, options)
    #
    # === primary_key
    #
    # By default primary key is ignored. If you wish primary key doesn't
    # be ignored you need to pass the primary key option on true.
    #
    def mass_insert values, args = {}
      extend ClassMethods
      @mass_insert_process = Process.new(values, mass_insert_options(args))
      @mass_insert_process.start
    end


    module ClassMethods

      def mass_insert_results
        Result.new(@mass_insert_process)
      end

      private

      def mass_insert_options options = {}
        options[:class_name]  ||= self
        options[:primary_key] ||= false
        options
      end
    end
  end
end
