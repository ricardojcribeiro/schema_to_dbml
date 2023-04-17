# frozen_string_literal: true

RSpec.describe SchemaToDbml do
  include SchemaConverterSpecHelper
  describe '#convert' do
    let(:schema_path) { "#{EXAMPLES_PATH}/example_schema.rb" }
    let(:expected_dbml_content) { File.read("#{EXAMPLES_PATH}/example_schema.dbml") }

    context 'when schema file exists' do
      it 'returns the expected DBML content' do
        expect(subject.convert(schema: schema_path)).to eq(expected_dbml_array)
      end
    end

    context 'when schema file does not exist' do
      let(:schema_path) { 'invalid_path' }

      it 'raises SchemaFileNotFoundError' do
        expect { subject.convert(schema: schema_path) }.to raise_error(Errors::SchemaFileNotFoundError)
      end
    end
  end
end
