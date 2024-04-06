# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateReviewService do
  let(:create_review_service) { described_class.new(params).perform }

  context 'when the params are valid' do
    let(:user) { create(:user) }
    let(:params) do
      {
        description: 'I loved this game',
        rating: 5,
        game_id: 1,
        user_id: user.id
      }
    end

    it 'creates a review' do
      aggregate_failures do
        expect { create_review_service }.to change(Review, :count).by(1)
        expect(create_review_service.success?).to be(true)
      end
    end
  end

  context 'when the params are invalid' do
    let(:params) do
      {
        description: 'I loved this game',
        rating: 5,
        game_id: 1
      }
    end

    it "doesn't create a review" do
      aggregate_failures do
        expect { create_review_service }.not_to change(Review, :count)
        expect(create_review_service.success?).to be(false)
      end
    end
  end
end
