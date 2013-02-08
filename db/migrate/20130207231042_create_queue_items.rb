class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.string :video_title
      t.integer :video_rating
      t.string :category
      t.integer :instant_queue_id

      t.timestamps
    end
  end
end
