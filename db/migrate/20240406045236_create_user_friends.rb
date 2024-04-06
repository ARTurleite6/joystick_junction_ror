# frozen_string_literal: true

class CreateUserFriends < ActiveRecord::Migration[7.1]
  def change
    create_table :user_friends do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
