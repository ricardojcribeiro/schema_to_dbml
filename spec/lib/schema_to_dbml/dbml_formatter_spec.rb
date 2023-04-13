# frozen_string_literal: true

RSpec.describe DbmlFormatter do
  it 'includes Constants' do
    expect(described_class.ancestors).to include(Helpers::Constants)
  end

  it 'includes FieldsFormatter' do
    expect(described_class.ancestors).to include(Formatters::FieldsFormatter)
  end

  describe '#format' do
    let(:table_name) { 'users' }
    let(:table_comment) { 'Represents a user who can create blog posts and comments' }
    let(:parsed_columns) do
      <<~COLUMNS
        t.string "name", null: false, comment: "Name of the user"
        t.integer "age", default: 0
        t.decimal "rating", precision: 3
        t.text "tags", array: true
      COLUMNS
    end

    let(:expected_dbml) do
      <<~DBML.strip
        Table users {
          name varchar [not null,note: 'Name of the user']
          age int [default: 0]
          rating decimal []
          tags text[] []
          Note: 'Represents a user who can create blog posts and comments'
        }
      DBML
    end

    let(:perform) do
      subject.format(table_name:, table_comment:, parsed_columns:)
    end

    it 'formats the given table name, table comment, and parsed columns into a DBML string' do
      expect(perform).to eq(expected_dbml)
    end
  end
end
