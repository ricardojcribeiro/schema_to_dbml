# frozen_string_literal: true

class Configuration
  def configure_from_hash(yaml_data)
    @custom_database_type = yaml_data['custom_database_type']
    @custom_dbml_content = yaml_data['custom_dbml_content']
    @custom_project_name = yaml_data['custom_project_name']
    @custom_project_notes = yaml_data['custom_project_notes']
    @custom_primary_key = yaml_data['custom_primary_key']
  end

  attr_accessor :custom_database_type,
                :custom_dbml_content,
                :custom_project_name,
                :custom_project_notes,
                :custom_primary_key
end
