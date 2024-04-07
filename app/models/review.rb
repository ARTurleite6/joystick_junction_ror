# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  description :text
#  like_count  :integer          default(0)
#  rating      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reviews_on_game_id  (game_id)
#  index_reviews_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  scope :top_reviews, lambda {
                        includes(:user).order(
                          like_count: :desc
                        )
                      }

  scope :top_rated, lambda {
    group(:game_id)
      .select('game_id, AVG(rating) as average_rating')
      .order('average_rating DESC')
      .limit(10)
  }

  scope :trending_games, lambda {
    where('created_at >= ?', 1.week.ago)
      .group(:game_id)
      .select('game_id, SUM(like_count) as total_likes')
      .order('total_likes DESC')
      .distinct(:game_id)
      .limit(10)
  }

  validates :rating, presence: true
end
