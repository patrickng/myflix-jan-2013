class CreateInstantQueues < ActiveRecord::Migration
  def change
    create_table :instant_queues do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
  end
end
