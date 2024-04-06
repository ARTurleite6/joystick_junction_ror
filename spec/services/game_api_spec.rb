require 'rails_helper'

RSpec.describe GameApi do
  describe '#find' do
    context 'when the game is not in the database' do
      it 'calls the StoreGameService' do
        expect(StoreGameService).to receive(:new).and_call_original
        expect_any_instance_of(StoreGameService).to receive(:perform)

        GameApi.find(1)
      end
    end
  end
end
