class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :reference_id
      t.integer :amount
      t.integer :user_id
      t.string :customer_token

      t.timestamps
    end
  end
end
