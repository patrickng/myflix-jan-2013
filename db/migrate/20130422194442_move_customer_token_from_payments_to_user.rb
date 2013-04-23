class MoveCustomerTokenFromPaymentsToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_token, :string
    remove_column :payments, :customer_token
  end
end
