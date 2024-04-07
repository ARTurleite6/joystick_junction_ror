require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #show' do
    context 'when user exists' do
      let(:user) { create(:user) }

      it 'returns user' do
        get user_path(user)

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.body).to eq(UserSerializer.new(user).to_json)
        end
      end
    end
  end
end
