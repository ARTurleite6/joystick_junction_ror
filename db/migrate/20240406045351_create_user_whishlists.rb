# frozen_string_literal: true

class CreateUserWhishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :user_whishlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_whishlists, %i[game_id user_id], unique: true
  end
end
