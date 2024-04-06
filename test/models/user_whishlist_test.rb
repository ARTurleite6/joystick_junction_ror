# == Schema Information
#
# Table name: user_whishlists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_whishlists_on_game_id_and_user_id  (game_id,user_id) UNIQUE
#  index_user_whishlists_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class UserWhishlistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
