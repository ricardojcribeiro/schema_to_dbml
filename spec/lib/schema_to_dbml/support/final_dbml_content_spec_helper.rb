# frozen_string_literal: true

module FinalDbmlContentSpecHelper
  def self.included(base)
    base.class_eval do
      let(:final_dbml_content) do
        "Project dbml_database_definition {\n  database_type: 'PostgreSQL'\n  Note: '# My Project Notes\nThis is a **project** that documents the database. Here are some key points:\n\n- Utilizes the custom primary key for better indexing\n- Specifies the appropriate database type (e.g., PostgreSQL)\n- Provides meaningful project information and descriptions\n'\n}\n\nTable users {\n  id integer [pk, unique, note: 'Unique identifier and primary key']\n  name varchar [not null,note: 'Name of the user']\n  email varchar [not null,note: 'Email of the user']\n  password varchar [default: `(now() + 'P1Y'::interval)`,not null,note: 'Encrypted password']\n  tags text[]\n  created_at timestamp [not null,note: 'Timestamp of when the user was created']\n  updated_at timestamp [not null,note: 'Timestamp of when the user was last updated']\n  Note: 'Represents a user who can create blog posts and comments'\n}\n\nTable posts {\n  id integer [pk, unique, note: 'Unique identifier and primary key']\n  title varchar [default: 'General Title',not null,note: 'Title of the post']\n  content text [not null,note: 'Content of the post']\n  context jsonb [default: '{}']\n  internal_description text [note: 'Internal description']\n  user_id bigint [not null,note: 'Foreign key of the user who created the post']\n  created_at timestamp [not null,note: 'Timestamp of when the post was created']\n  updated_at timestamp [not null,note: 'Timestamp of when the post was last updated']\n  Note: 'Represents a blog post created by a user'\n}\n\nTable comments {\n  id integer [pk, unique, note: 'Unique identifier and primary key']\n  content text [not null,note: 'Content of the comment']\n  user_id bigint [not null,note: 'Foreign key of the user who created the comment']\n  post_id bigint [not null,note: 'Foreign key of the post that the comment belongs to']\n  created_at timestamp [not null,note: 'Timestamp of when the comment was created']\n  updated_at timestamp [not null,note: 'Timestamp of when the comment was last updated']\n  Note: 'Represents a comment created by a user on a specific blog post'\n}\n\nRef fk_rails_comments_posts:comments.post_id - posts.id\n\nRef fk_rails_comments_users:comments.user_id - users.id\n\nRef fk_rails_posts_users:posts.user_id - users.id [delete: cascade]\n\n"
      end

      let(:expected_default_response) do
        {
          custom_primary_key: "id integer [pk, unique, note: 'Unique identifier and primary key']",
          custom_database_type: "'PostgreSQL'",
          custom_project_name: 'dbml_database_definition',
          custom_project_notes:  "# My Project Notes\nThis is a **project** that documents the database. Here are some key points:\n\n- Utilizes the custom primary key for better indexing\n- Specifies the appropriate database type (e.g., PostgreSQL)\n- Provides meaningful project information and descriptions\n"
        }
      end
    end
  end
end
