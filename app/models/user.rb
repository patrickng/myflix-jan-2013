class User < ActiveRecord::Base
  attr_accessible :email_address, :full_name, :password
end
