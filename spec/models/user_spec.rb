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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:username) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:friends) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:reviews_games) }
    it { is_expected.to have_many(:wishlists) }
    it { is_expected.to have_many(:wishlist_games) }
  end
end
