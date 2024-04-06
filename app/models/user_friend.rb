# frozen_string_literal: true

# == Schema Information
#
# Table name: user_friends
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_friends_on_friend_id  (friend_id)
#  index_user_friends_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class UserFriend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
