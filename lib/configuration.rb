# frozen_string_literal: true

class Configuration
  def configure_from_hash(yaml_data)
    @custom_database_type = yaml_data['custom_database_type']
    @custom_dbml_content = yaml_data['custom_dbml_content']
    @custom_dbml_file_path = yaml_data['custom_dbml_file_path']
    @custom_primary_key = yaml_data['custom_primary_key']
    @custom_project_name = yaml_data['custom_project_name']
    @custom_project_notes = yaml_data['custom_project_notes']
    @custom_tables = yaml_data['custom_tables']
  end

  attr_accessor :custom_database_type,
                :custom_dbml_content,
                :custom_dbml_file_path,
                :custom_primary_key,
                :custom_project_name,
                :custom_project_notes,
                :custom_tables
end
