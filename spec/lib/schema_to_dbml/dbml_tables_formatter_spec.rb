# frozen_string_literal: true

RSpec.describe DbmlTablesFormatter do
  include DbmlCustomContentSpecHelper

  stub_custom_config

  it 'includes Constants' do
    expect(described_class.ancestors).to include(Helpers::Constants)
  end

  it 'includes FieldsFormatter' do
    expect(described_class.ancestors).to include(Formatters::FieldsFormatter)
  end

  describe '#format' do
    let(:table_name) { 'users' }
    let(:table_comment) { 'Represents a user who can create blog posts and comments' }
    let(:table_attributes) do
      <<~COLUMNS
        t.string "name", null: false, comment: "Name of the user"
        t.integer "age", default: 0
        t.decimal "rating", precision: 3
        t.string "gender", limit: 1
        t.string "password",  default: -> { "(now() + 'P1Y'::interval)" }, null: false, comment: "Encrypted password"
        t.jsonb "context", default: {}
        t.text "tags", array: true
        t.string "email", default: ''
        t.boolean "active", default: true
        t.index ["email"], name: "index_users_on_email", unique: true
      COLUMNS
    end

    let(:expected_dbml) do
      <<~DBML.strip
        Table users {
          id integer [pk, unique, note: '''Unique identifier and primary key''']
          name varchar [not null,note: '''Name of the user''']
          age int [default: 0]
          rating decimal
          gender varchar(1)
          password varchar [default: `(now() + 'P1Y'::interval)`,not null,note: '''Encrypted password''']
          context jsonb [default: '{}']
          tags text[]
          email varchar [default: '']
          active bool [default: true]
          indexes {
            (email) [unique, name: 'index_users_on_email']
          }
          Note: '''Represents a user who can create blog posts and comments'''
        }
      DBML
    end

    let(:perform) do
      subject.format(table_name:, table_comment:, table_attributes:)
    end

    it 'formats the given table name, table comment, and parsed columns into a DBML string' do
      expect(perform).to eq(expected_dbml)
    end

    context 'when custom_primary_key is defined' do
      let(:custom_primary_key) { "custom_id varchar [pk, note: '''my custom id''']" }
      let(:expected_dbml) do
        <<~DBML.strip
          Table users {
            custom_id varchar [pk, note: '''my custom id''']
            name varchar [not null,note: '''Name of the user''']
            age int [default: 0]
            rating decimal
            gender varchar(1)
            password varchar [default: `(now() + 'P1Y'::interval)`,not null,note: '''Encrypted password''']
            context jsonb [default: '{}']
            tags text[]
            email varchar [default: '']
            active bool [default: true]
            indexes {
              (email) [unique, name: 'index_users_on_email']
            }
            Note: '''Represents a user who can create blog posts and comments'''
          }
        DBML
      end

      before { configuration.custom_primary_key = custom_primary_key }

      it 'formats the given custom primary key' do
        expect(perform).to eq(expected_dbml)
      end
    end

    context 'when table comment is empty' do
      let(:table_comment) { nil }

      let(:expected_dbml) do
        <<~DBML.strip
            Table users {
            id integer [pk, unique, note: '''Unique identifier and primary key''']
            name varchar [not null,note: '''Name of the user''']
            age int [default: 0]
            rating decimal
            gender varchar(1)
            password varchar [default: `(now() + 'P1Y'::interval)`,not null,note: '''Encrypted password''']
            context jsonb [default: '{}']
            tags text[]
            email varchar [default: '']
            active bool [default: true]
            indexes {
              (email) [unique, name: 'index_users_on_email']
            }
          }
        DBML
      end

      it 'does not return note section' do
        expect(perform).to eq(expected_dbml)
      end
    end

    context 'with custom column type' do
      let(:table_name) { 'posts' }
      let(:table_attributes) do
        <<~COLUMNS
          t.string "status", default: "draft", null: false
        COLUMNS
      end
      let(:table_comment) { nil }
      let(:expected_dbml) do
        <<~DBML.strip
          Table posts {
            id integer [pk, unique, note: '''Unique identifier and primary key''']
            status post_status [default: 'draft',not null]
          }
        DBML
      end

      it 'returns status with post status' do
        expect(perform).to eq(expected_dbml)
      end

      context 'when custom tables is empty' do
        before { configuration.custom_tables = nil }

        let(:expected_dbml) do
          <<~DBML.strip
            Table posts {
              id integer [pk, unique, note: '''Unique identifier and primary key''']
              status varchar [default: 'draft',not null]
            }
          DBML
        end

        it 'returns post status with varchar type' do
          expect(perform).to eq(expected_dbml)
        end
      end
    end
  end
end
