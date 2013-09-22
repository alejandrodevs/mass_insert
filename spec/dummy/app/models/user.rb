class User < ActiveRecord::Base
  attr_accessible :age, :email, :name, :money, :active, :checked, :birthday
end
