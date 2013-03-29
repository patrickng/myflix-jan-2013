class RenameVideoUrlToUrl < ActiveRecord::Migration
  def change
    rename_column :videos, :video_url, :url
  end
end
