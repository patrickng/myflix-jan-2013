class AddQueueItemsPosition < ActiveRecord::Migration
  def change
  	add_column :queue_items, :position, :integer
  end
end
