# frozen_string_literal: true

RSpec.describe Formatters::IndexFormatter do
  subject do
    Class.new do
      include Formatters::IndexFormatter
    end.new
  end

  describe '#format_index' do
    let(:columns) { '"email", "name"' }
    let(:index_name) { 'the_index_name' }
    let(:unique) { 'true' }
    let(:perform) { subject.format_index(columns, index_name, unique) }

    it 'returns the index' do
      expect(perform).to eq("    (email, name) [unique, name: 'the_index_name']")
    end

    context 'when unique does not exist' do
      let(:unique) { nil }

      it 'returns the index' do
        expect(perform).to eq("    (email, name) [name: 'the_index_name']")
      end
    end
  end
end
