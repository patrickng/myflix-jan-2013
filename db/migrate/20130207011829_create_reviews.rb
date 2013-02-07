class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.integer :max_rating, default: 5
      t.text :review

      t.timestamps
    end
  end
end
