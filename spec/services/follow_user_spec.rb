require 'rails_helper'

RSpec.describe FollowUserService do
  let(:follow_user) { described_class.new(params).perform }

  context 'when the params are valid' do
    let(:user) { create(:user) }
    let(:followed_user) { create(:user) }
    let(:params) do
      {
        user_id: user.id,
        friend_id: followed_user.id
      }
    end

    it 'creates a follow' do
      aggregate_failures do
        expect { follow_user }.to change(UserFriend, :count).by(1)
        expect(follow_user.success?).to be(true)
      end
    end
  end

  context 'when the params are invalid' do
    let(:user) { create(:user) }
    let(:params) do
      {
        user_id: user.id
      }
    end

    it "doesn't create a follow" do
      aggregate_failures do
        expect { follow_user }.not_to change(UserFriend, :count)
        expect(follow_user.success?).to be(false)
      end
    end
  end
end
