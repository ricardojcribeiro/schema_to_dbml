# frozen_string_literal: true

require 'yaml'
require_relative 'configuration'
require_relative 'schema_to_dbml/build_dbml_content'
require_relative 'schema_to_dbml/errors/schema_file_not_found_error'
require_relative 'schema_to_dbml/schema_converter'
require_relative 'schema_to_dbml/version'

class SchemaToDbml
  DEFAULT_CONFIG_FILE = File.join(__dir__, 'schema_to_dbml/configs/custom_config.yml')

  class << self
    def configuration
      @configuration ||= begin
        config = Configuration.new
        load_configuration_from_yaml(DEFAULT_CONFIG_FILE, config)
        config
      end
    end

    def load_configuration_from_yaml(file_path, config = configuration)
      raise 'Configuration file not found Error' unless File.exist?(file_path)

      yaml_data = YAML.load_file(file_path)
      configure(config) do |c|
        c.custom_primary_key = yaml_data['custom_primary_key']
        c.custom_database_type = yaml_data['custom_database_type']
        c.custom_project_name = yaml_data['custom_project_name']
        c.custom_project_notes = yaml_data['custom_project_notes']
      end
    end

    def configure(config = configuration)
      yield(config)
    end
  end

  def initialize(
    build_dbml_content: BuildDbmlContent.new,
    schema_converter: SchemaConverter.new
  )
    @build_dbml_content = build_dbml_content
    @schema_converter = schema_converter
  end

  def convert(schema:)
    converted = schema_converter.convert(schema_content: schema_content(schema))

    build_dbml_content.build(converted:)
  end

  private

  def schema_content(schema)
    raise Errors::SchemaFileNotFoundError unless File.exist?(schema)

    File.read(schema)
  end

  attr_accessor :build_dbml_content, :schema_converter
end
