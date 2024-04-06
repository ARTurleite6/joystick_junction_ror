# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :games, id: false, primary_key: :id do |t|
      t.integer :id, null: false, index: { unique: true }
      t.string :name, null: false
      t.decimal :total_rating
      t.string :image_url
      t.text :summary

      t.timestamps
    end

    create_table :reviews do |t|
      t.text :description
      t.integer :rating, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :like_count, default: 0

      t.timestamps
    end
  end
end
