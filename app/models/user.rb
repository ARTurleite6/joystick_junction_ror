# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :first_name, :last_name, :username, presence: true

  has_many :friends, class_name: 'Friendship'
  has_many :reviews, dependent: :destroy
  has_many :reviews_games, through: :reviews, source: :game

  has_many :wishlists, dependent: :destroy
  has_many :wishlist_games, through: :wishlists, source: :game

  def number_of_friends
    friends.count
  end
end
