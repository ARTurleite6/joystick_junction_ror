# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserWhishlist, type: :model do
  subject { create(:user_whishlist) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:game_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
