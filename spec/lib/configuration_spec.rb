# frozen_string_literal: true

RSpec.describe Configuration do
  let(:configuration) { Configuration.new }

  describe 'custom_primary_key' do
    context 'when not set' do
      it 'returns an empty string' do
        expect(configuration.custom_primary_key).to eq('')
      end
    end

    context 'when set' do
      let(:custom_primary_key) { 'id UUID [pk, unique, not null, default: `gen_random_uuid()`]' }

      before do
        configuration.custom_primary_key = custom_primary_key
      end

      it 'returns the custom_primary_key' do
        expect(configuration.custom_primary_key).to eq(custom_primary_key)
      end
    end
  end
end
