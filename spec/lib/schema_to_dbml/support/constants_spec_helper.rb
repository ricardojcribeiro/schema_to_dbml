# frozen_string_literal: true

module ConstantsSpecHelper
  def self.included(base)
    base.class_eval do
      let(:expected_row_values) do
        [
          { type: 'string', name: 'name', default: nil, null: 'null: false', comment: 'Name of the user', precision: nil, array: nil },
          { type: 'string', name: 'email', default: nil, null: 'null: false', comment: 'Email of the user', precision: nil, array: nil },
          { type: 'string', name: 'password', default: "default: -> { \"(now() + 'P1Y'::interval)\" }", null: 'null: false', comment: 'Encrypted password', precision: nil, array: nil },
          { type: 'text', name: 'tags', default: nil, null: nil, comment: nil, precision: nil, array: "true" },
          { type: 'datetime', name: 'created_at', default: nil, null: 'null: false', comment: 'Timestamp of when the user was created', precision: nil,
            array: nil },
          { type: 'datetime', name: 'updated_at', default: nil, null: 'null: false', comment: 'Timestamp of when the user was last updated',
            precision: nil, array: nil },
          { type: 'string', name: 'title', default: "default: \"General Title\"", null: 'null: false', comment: 'Title of the post', precision: nil, array: nil },
          { type: 'text', name: 'content', default: nil, null: 'null: false', comment: 'Content of the post', precision: nil, array: nil },
          { type: 'jsonb', name: 'context', default: "default: {}", null: nil, comment: nil, precision: nil, array: nil },
          { type: 'text', name: 'internal_description', default: nil, null: nil, comment: 'Internal description', precision: nil, array: nil },
          { type: 'bigint', name: 'user_id', default: nil, null: 'null: false', comment: 'Foreign key of the user who created the post', precision: nil,
            array: nil },
          { type: 'datetime', name: 'created_at', default: nil, null: 'null: false', comment: 'Timestamp of when the post was created', precision: nil,
            array: nil },
          { type: 'datetime', name: 'updated_at', default: nil, null: 'null: false', comment: 'Timestamp of when the post was last updated',
            precision: nil, array: nil },
          { type: 'text', name: 'content', default: nil, null: 'null: false', comment: 'Content of the comment', precision: nil, array: nil },
          { type: 'bigint', name: 'user_id', default: nil, null: 'null: false', comment: 'Foreign key of the user who created the comment', precision: nil,
            array: nil },
          { type: 'bigint', name: 'post_id', default: nil, null: 'null: false', comment: 'Foreign key of the post that the comment belongs to',
            precision: nil, array: nil },
          { type: 'datetime', name: 'created_at', default: nil, null: 'null: false', comment: 'Timestamp of when the comment was created', precision: nil,
            array: nil },
          { type: 'datetime', name: 'updated_at', default: nil, null: 'null: false', comment: 'Timestamp of when the comment was last updated',
            precision: nil, array: nil }
        ]
      end
    end
  end
end
