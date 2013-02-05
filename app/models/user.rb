class User < ActiveRecord::Base
  has_secure_password

  validates :full_name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true
end