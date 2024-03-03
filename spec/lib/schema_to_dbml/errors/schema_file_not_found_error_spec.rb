# frozen_string_literal: true

RSpec.describe Errors::SchemaFileNotFoundError do
  describe '#initialize' do
    context 'when no message is provided' do
      let(:error) { described_class.new }

      it 'sets a default message' do
        expect(error.message).to eq('schema.rb file not found.')
      end
    end

    context 'when a message is provided' do
      let(:custom_message) { 'Custom error message' }
      let(:error) { described_class.new(custom_message) }

      it 'sets the provided message' do
        expect(error.message).to eq(custom_message)
      end
    end
  end
end
