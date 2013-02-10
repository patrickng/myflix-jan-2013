class User < ActiveRecord::Base
  has_secure_password

  validates :full_name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :reviews
  has_many :instant_queue
  has_many :queue_items

  def has_in_queue?(video)
    queue_items.map(&:video).include?(video)
  end
end