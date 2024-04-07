# == Schema Information
#
# Table name: games
#
#  id           :integer          not null
#  image_url    :string
#  name         :string           not null
#  summary      :text
#  total_rating :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_games_on_id  (id) UNIQUE
#
class Game < ApplicationRecord
  self.primary_key = "id"

  has_many :user_whishlists, dependent: :destroy
  has_many :users, through: :user_whishlists

  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, source: :user

  validates :id, presence: true
  validates :name, presence: true
end
