# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  avatar     :string
#  first_name :string           not null
#  last_name  :string           not null
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :friends, class_name: 'UserFriend'
  has_many :reviews, dependent: :destroy
  has_many :reviews_games, through: :reviews, source: :game

  has_many :wishlists, class_name: 'UserWhishlist', dependent: :destroy, inverse_of: :user
  has_many :wishlist_games, through: :wishlists, source: :game

  has_one_attached :avatar, dependent: :destroy

  validates :first_name, :last_name, :username, presence: true

  def number_of_friends
    friends.count
  end
end
