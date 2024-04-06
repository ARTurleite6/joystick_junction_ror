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
  has_many :wishlists, dependent: :destroy

  def number_of_friends
    friends.count
  end
end
