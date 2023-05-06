# frozen_string_literal: true

RSpec.describe SchemaToDbml do
  include FinalDbmlContentSpecHelper

  describe '#convert' do
    let(:schema_path) { "#{EXAMPLES_PATH}/example_schema.rb" }
    let(:expected_dbml_content) { File.read("#{EXAMPLES_PATH}/example_schema.dbml") }
    let(:perform) { subject.convert(schema: schema_path) }

    context 'when schema file exists' do
      it 'returns the expected DBML content' do
        expect(perform).to eq(final_dbml_content)
      end
    end

    context 'when schema file does not exist' do
      let(:schema_path) { 'invalid_path' }

      it 'raises SchemaFileNotFoundError' do
        expect { perform[:tables] }.to raise_error(Errors::SchemaFileNotFoundError)
      end
    end
  end
end
