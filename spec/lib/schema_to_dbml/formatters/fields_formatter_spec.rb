# frozen_string_literal: true

RSpec.describe Formatters::FieldsFormatter do
  include Formatters::FieldsFormatter

  describe '#format_type' do
    let(:perform) { format_type(type:, array:) }
    let(:type) { nil }
    let(:array) { 'false' }

    context 'when type is nil' do
      it 'returns an empty string' do
        expect(perform).to eq('')
      end
    end

    context 'when type is string and array is false' do
      let(:type) { 'string' }
      it 'returns the type' do
        expect(perform).to eq('varchar')
      end
    end

    context 'when type is boolean and array is false' do
      let(:type) { 'boolean' }
      it 'returns the type' do
        expect(perform).to eq('bool')
      end
    end

    context 'when type is datetime and array is false' do
      let(:type) { 'datetime' }
      it 'returns the type' do
        expect(perform).to eq('timestamp')
      end
    end

    context 'when type is integer and array is true' do
      let(:type) { 'integer' }
      let(:array) { 'true' }
      it 'returns the type with array brackets' do
        expect(perform).to eq('int[]')
      end
    end

    context 'when type is not pre defined type' do
      let(:type) { 'text' }
      it 'returns the type' do
        expect(perform).to eq('text')
      end
    end

    context 'when array is true and type is empty' do
      let(:type) { '' }
      let(:array) { 'true' }
      it 'returns an empty string' do
        expect(perform).to eq('')
      end
    end
  end

  describe '#format_default' do
    it 'returns an empty string when default is nil' do
      expect(format_default(default: nil)).to eq('')
    end

    it 'returns an empty string when default is blank' do
      expect(format_default(default: '')).to eq('')
    end

    it 'returns an empty string when the default value is an empty string' do
      default = "default: ''"
      expected_output = "default: ''"
      expect(format_default(default:)).to eq(expected_output)
    end

    it 'formats number default correctly' do
      default = 'default: 0'
      expected_output = 'default: 0'
      expect(format_default(default:)).to eq(expected_output)
    end

    it 'formats lambda default correctly' do
      default = "default: -> { \"(now() + 'P1Y'::interval)\" }"
      expected_output = 'default: `(now() + \'P1Y\'::interval)`'
      expect(format_default(default:)).to eq(expected_output)
    end

    it 'formats boolean default (true) correctly' do
      default = 'default: true'
      expected_output = 'default: true'
      expect(format_default(default:)).to eq(expected_output)
    end

    it 'formats boolean default (false) correctly' do
      default = 'default: false'
      expected_output = 'default: false'
      expect(format_default(default:)).to eq(expected_output)
    end

    it 'formats string default correctly' do
      default = "default: 'created'"
      expected_output = "default: 'created'"
      expect(format_default(default:)).to eq(expected_output)
    end

    it 'formats empty hash default correctly' do
      default = 'default: {}'
      expected_output = "default: '{}'"
      expect(format_default(default:)).to eq(expected_output)
    end
  end

  describe '#format_null' do
    let(:perform) { format_null(null:) }
    let(:null) { nil }

    context 'when null is nil' do
      it 'returns an empty string' do
        expect(perform).to eq('')
      end
    end

    context 'when null is blank' do
      let(:null) { '' }
      it 'returns an empty string' do
        expect(perform).to eq('')
      end
    end

    context 'when null is present' do
      let(:null) { 'true' }
      it 'returns the formatted null string' do
        expect(perform).to eq('not null')
      end
    end
  end

  describe '#format_comment' do
    let(:perform) { format_comment(comment:) }
    let(:comment) { nil }

    context 'when comment is nil' do
      it 'returns an empty string' do
        expect(perform).to eq('')
      end
    end

    context 'when comment is blank' do
      let(:comment) { '' }
      it 'returns an empty string' do
        expect(perform).to eq('')
      end
    end

    context 'when comment is present' do
      let(:comment) { "This is a comment with a ' quote" }
      it 'returns the formatted comment string' do
        expect(perform).to eq("note: 'This is a comment with a \\' quote'")
      end
    end
  end
end
