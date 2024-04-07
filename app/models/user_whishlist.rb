# frozen_string_literal: true

# == Schema Information
#
# Table name: user_whishlists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_whishlists_on_game_id              (game_id)
#  index_user_whishlists_on_game_id_and_user_id  (game_id,user_id) UNIQUE
#  index_user_whishlists_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
class UserWhishlist < ApplicationRecord
  belongs_to :user, inverse_of: :wishlists
  belongs_to :game
end
