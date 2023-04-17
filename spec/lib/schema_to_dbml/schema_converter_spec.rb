# frozen_string_literal: true

describe SchemaConverter do
  include SchemaConverterSpecHelper

  let(:schema_content) { File.read("#{EXAMPLES_PATH}/example_schema.rb") }

  describe '#convert' do
    let(:perform) { subject.convert(schema_content:) }

    context 'when schema_content contains 3 tables' do
      it 'matches all table definitions' do
        expect(perform.size).to eq(3)
      end

      it 'matches the dbml array' do
        expect(perform).to eq(expected_dbml_array)
      end
    end
  end
end
