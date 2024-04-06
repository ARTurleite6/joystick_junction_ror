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
#  game_id     :integer          not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reviews_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  validates :rating, :game_id, presence: true

  scope :top_reviews, lambda {
                        includes(:user).order(
                          like_count: :desc
                        )
                      }

  belongs_to :user
end
