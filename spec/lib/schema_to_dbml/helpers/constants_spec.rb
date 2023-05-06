# frozen_string_literal: true

RSpec.describe Helpers::Constants do
  include ConstantsSpecHelper
  let(:file) { EXAMPLES_PATH }
  let(:schema) { File.read("#{EXAMPLES_PATH}/example_schema.rb") }

  describe 'TABLES_REGEXP' do
    let(:perform) { schema.scan(described_class::TABLES_REGEXP) }

    it 'matches all table definitions' do
      expect(perform.size).to eq(3)
    end

    it 'matches the table name' do
      expect(perform[0][0]).to eq('users')
      expect(perform[1][0]).to eq('posts')
      expect(perform[2][0]).to eq('comments')
    end

    it 'matches the table comment' do
      expect(perform[0][1]).to eq('Represents a user who can create blog posts and comments')
      expect(perform[1][1]).to eq('Represents a blog post created by a user')
      expect(perform[2][1]).to eq('Represents a comment created by a user on a specific blog post')
    end
  end

  describe 'COLUMNS_REGEXP' do
    let(:perform) { schema.scan(described_class::COLUMNS_REGEXP) }

    it 'matches all column definitions' do
      expect(perform.size).to eq(17)
    end

    it 'matches the column type' do
      matches = perform

      17.times do |i|
        expect(matches[i]).to eq(expected_row_values[i].values_at(:type, :name, :default, :null, :comment, :precision, :array))
      end
    end
  end

  describe 'RELATIONS_REGEXP' do
    let(:perform) { schema.scan(described_class::RELATIONS_REGEXP) }

    it 'matches all relation definitions' do
      expect(perform.size).to eq(3)
    end

    it 'matches first relation' do
      expect(perform[0]).to eq(['comments', 'posts', 'post_id', nil])
    end

    it 'matches second relation' do
      expect(perform[1]).to eq(['comments', 'users', nil, nil])
    end

    it 'matches third relation' do
      expect(perform[2]).to eq(['posts', 'users', nil, 'cascade'])
    end
  end
end
