# frozen_string_literal: true

describe DefaultFieldFormatterHelper do
  describe 'DEFAULT_PATTERNS' do
    it 'contains the correct number of patterns' do
      expect(described_class::DEFAULT_PATTERNS.size).to eq(6)
    end
  end

  describe 'REGEXS' do
    it 'contains the correct lambda regex pattern and its replacement' do
      expect(described_class::DEFAULT_LAMBDA_REGEX).to eq([/default: -> \{ "(.*?)" \}/, 'default: `\1`'])
    end

    it 'contains the correct hash regex pattern and its replacement' do
      expect(described_class::DEFAULT_HASH_REGEX).to eq([/default: (\{(?:[^}]*?)\})/, 'default: \'\1\''])
    end

    it 'contains the correct array regex pattern and its replacement' do
      expect(described_class::DEFAULT_ARRAY_REGEX).to eq([/default: (\[.*?\])/, 'default: \'\1\''])
    end

    it 'contains the correct string regex pattern and its replacement' do
      expect(described_class::DEFAULT_STRING_REGEX).to eq([/default: "(.*?)"/, 'default: \'\1\''])
    end

    it 'contains the correct number regex pattern and its replacement' do
      expect(described_class::DEFAULT_NUMBER_REGEX).to eq([/default: (\d+(?:\.\d+)?)/, 'default: \1'])
    end

    it 'contains the correct boolean regex pattern and its replacement' do
      expect(described_class::DEFAULT_BOOLEAN_REGEX).to eq([/default: (true|false)/, 'default: \1'])
    end
  end
end
