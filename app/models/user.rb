class User < ActiveRecord::Base
  validates :full_name, presence: true
  validates :email_address, presence: true
  validates :password, presence: true
end