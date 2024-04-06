class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :rating, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.integer :game_id, null: false
      t.integer :like_count, default: 0

      t.timestamps
    end
  end
end
