# frozen_string_literal: true

RSpec.describe Formatters::FieldsFormatter do
  include Formatters::FieldsFormatter

  describe '#format_type' do
    context 'when given a valid data type' do
      it 'returns the formatted data type as a string' do
        expect(format_type(value: :string, array: false)).to eq('varchar')
        expect(format_type(value: :integer, array: false)).to eq('int')
        expect(format_type(value: :boolean, array: false)).to eq('bool')
        expect(format_type(value: :datetime, array: false)).to eq('timestamp')
      end

      context 'when given the optional array argument' do
        it 'returns the formatted data type with square brackets for arrays' do
          expect(format_type(value: :string, array: true)).to eq('varchar[]')
          expect(format_type(value: :integer, array: true)).to eq('int[]')
          expect(format_type(value: :boolean, array: true)).to eq('bool[]')
          expect(format_type(value: :datetime, array: true)).to eq('timestamp[]')
        end
      end
    end

    context 'when given an invalid data type' do
      it 'returns nil' do
        expect(format_type(value: :foo, array: false)).to be_nil
      end
    end

    context 'when given a nil value' do
      it 'returns nil' do
        expect(format_type(value: nil, array: false)).to be_nil
      end
    end
  end

  describe '#format_default' do
    context 'when given a non-blank default value' do
      it 'returns the formatted default value as a string' do
        expect(format_default(default: 'foo')).to eq('default: foo')
        expect(format_default(default: 123)).to eq('default: 123')
        expect(format_default(default: true)).to eq('default: true')
      end
    end

    context 'when given a blank default value' do
      it 'returns an empty string' do
        expect(format_default(default: '')).to eq('')
        expect(format_default(default: nil)).to eq('')
      end
    end
  end

  describe '#format_comment' do
    context 'when given a non-blank comment' do
      it 'returns the formatted comment as a string' do
        expect(format_comment('This is a comment')).to eq('note: This is a comment')
        expect(format_comment('Another comment')).to eq('note: Another comment')
      end
    end

    context 'when given a blank comment' do
      it 'returns an empty string' do
        expect(format_comment('')).to eq('')
        expect(format_comment(nil)).to eq('')
      end
    end
  end
end
