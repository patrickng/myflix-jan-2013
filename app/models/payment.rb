class Payment < ActiveRecord::Base
  # attr_accessible :amount, :customer_token, :reference_id, :user_id
  monetize :amount, allow_nil: true, as: 'charge_amount'
  belongs_to :user
end
