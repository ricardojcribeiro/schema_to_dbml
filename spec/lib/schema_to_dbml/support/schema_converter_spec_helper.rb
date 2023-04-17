# frozen_string_literal: true

module SchemaConverterSpecHelper
  def self.included(base)
    base.class_eval do
      let(:expected_dbml_array) do
        [
          "Table users {\n  name varchar [not null,note: 'Name of the user']\n  email varchar [not null,note: 'Email of the user']\n  password_digest varchar [not null,note: 'Encrypted password of the user']\n  tags text[] []\n  created_at timestamp [not null,note: 'Timestamp of when the user was created']\n  updated_at timestamp [not null,note: 'Timestamp of when the user was last updated']\n  Note: 'Represents a user who can create blog posts and comments'\n}", 
          "Table posts {\n  title varchar [not null,note: 'Title of the post']\n  content text [not null,note: 'Content of the post']\n  internal_description text [note: 'Internal description']\n  user_id bigint [not null,note: 'Foreign key of the user who created the post']\n  created_at timestamp [not null,note: 'Timestamp of when the post was created']\n  updated_at timestamp [not null,note: 'Timestamp of when the post was last updated']\n  Note: 'Represents a blog post created by a user'\n}", 
          "Table comments {\n  content text [not null,note: 'Content of the comment']\n  user_id bigint [not null,note: 'Foreign key of the user who created the comment']\n  post_id bigint [not null,note: 'Foreign key of the post that the comment belongs to']\n  created_at timestamp [not null,note: 'Timestamp of when the comment was created']\n  updated_at timestamp [not null,note: 'Timestamp of when the comment was last updated']\n  Note: 'Represents a comment created by a user on a specific blog post'\n}"
        ]
      end
    end
  end
end
