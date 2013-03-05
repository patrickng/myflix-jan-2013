class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime

    User.all.each do |user|
      user.generate_token
      user.save(validate: false)
    end
  end
end
