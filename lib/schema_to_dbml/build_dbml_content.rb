# frozen_string_literal: true

class BuildDbmlContent
  def initialize(configuration: SchemaToDbml.configuration)
    @configuration = configuration
  end

  def build(converted:)
    dbml = []
    dbml << project_header
    dbml << tables_section(converted[:tables])
    dbml << relations_section(converted[:relations])

    dbml.join("\n\n")
  end

  private

  def project_header
    header = "Project #{project_name} {\n"
    header += "  database_type: #{custom_database_type}\n"
    header += "  Note: '#{custom_project_notes}'\n"
    header += '}'
    header
  end

  def tables_section(tables)
    tables.join("\n\n")
  end

  def relations_section(relations)
    relations.join("\n\n")
  end

  def project_name
    configuration.custom_project_name
  end

  def custom_database_type
    configuration.custom_database_type
  end

  def custom_project_notes
    configuration.custom_project_notes
  end

  attr_reader :configuration
end
