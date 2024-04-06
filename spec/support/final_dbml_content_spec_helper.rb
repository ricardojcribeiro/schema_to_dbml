# frozen_string_literal: true

module FinalDbmlContentSpecHelper
  def self.included(base)
    base.class_eval do
      let(:final_dbml_content_file) do
        File.open("#{SUPPORT_FILES_PATH}/example_final_dbml_content.dbml")
      end

      let(:final_dbml_content) { final_dbml_content_file.read }

      let(:expected_default_response) do
        {
          custom_primary_key: "id integer [pk, unique, note: '''Unique identifier and primary key''']",
          custom_database_type: 'PostgreSQL',
          custom_project_name: 'dbml_database_definition',
          custom_project_notes: "# My Project Notes\nThis is a **project** that documents the database. Here are some key points:\n\n- Utilizes the custom primary key for better indexing\n- Specifies the appropriate database type (e.g., PostgreSQL)\n- Provides meaningful project information and descriptions\n"
        }
      end
    end
  end
end
