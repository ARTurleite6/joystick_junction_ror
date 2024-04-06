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
require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:id) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:reviewers) }
    it { is_expected.to have_many(:user_whishlists) }
    it { is_expected.to have_many(:users) }
  end
end
