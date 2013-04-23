class MoveCustomerTokenFromPaymentsToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_token, :string
    User.all.each do |user|
      user.customer_token = user.payments.first.try(:customer_token)
    end
    remove_column :payments, :customer_token
  end
end
