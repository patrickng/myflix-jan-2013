class Invitation < ActiveRecord::Base
  # attr_accessible :recipient_email, :sender_id, :sent_at
  belongs_to :sender, class_name: 'User'
  has_one :recipient, class_name: 'User'
end
