class RemoveCategoryIdFromVideosTable < ActiveRecord::Migration
  def up
    remove_column :videos, :category_id
  end
  def down
    add_column :videos, :category_id, :integer
  end
end
