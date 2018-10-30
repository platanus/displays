require 'rails_helper'

RSpec.describe DisplaysController, type: :controller do
  describe 'GET #show' do
    context 'by display host_uuid' do
      let!(:display) { create(:display) }

      before do
        get :show, params: { host_uuid: display.host_uuid }
      end

      it 'return a decorated display' do
        expect(controller.display).to be_decorated_with(DisplayDecorator)
      end
    end
  end
end
