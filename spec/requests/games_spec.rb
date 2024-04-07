require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'GET #games' do
    context 'when games exists' do

      it 'returns games' do
        get games_path

        aggregate_failures do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
