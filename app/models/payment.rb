class Payment < ActiveRecord::Base
  # attr_accessible :amount, :customer_token, :reference_id, :user_id
  belongs_to :user
end
