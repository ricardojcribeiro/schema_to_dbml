# frozen_string_literal: true

describe SchemaConverter do
  include SchemaConverterSpecHelper

  let(:schema_content) { File.read("#{EXAMPLES_PATH}/example_schema.rb") }

  describe '#convert' do
    let(:perform) { subject.convert(schema_content:) }

    context 'when schema_content contains 3 tables' do
      it 'matches all table definitions' do
        expect(perform[:tables].size).to eq(3)
      end

      it 'matches the ytables array' do
        expect(perform[:tables]).to eq(expected_tables_array)
      end
    end

    context 'when schema_content contains 3 relations' do
      it 'matches all relations definitions' do
        expect(perform[:relations].size).to eq(3)
      end

      it 'matches the relations array' do
        expect(perform[:relations]).to eq(expected_relations_array)
      end
    end
  end
end
