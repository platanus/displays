require 'rails_helper'

RSpec.describe DisplayDecorator do
  describe '#present_url' do
    context 'blank url' do
      let(:display) { create(:display).decorate }

      it 'return the setup display url' do
        expect(display.present_url).to eq(setup_display_path(display.host_uuid))
      end
    end

    context 'user url' do
      let(:display) { create(:display, :setup).decorate }

      it 'return the url' do
        expect(display.present_url).to eq(display.url)
      end
    end
  end
end
