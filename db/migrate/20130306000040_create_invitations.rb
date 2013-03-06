class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.string :recipient_full_name
      t.string :recipient_email_address
      t.text :recipient_message
      t.datetime :sent_at

      t.timestamps
    end
  end
end
