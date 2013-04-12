class User < ActiveRecord::Base
  attr_accessible :age, :email, :name
end
