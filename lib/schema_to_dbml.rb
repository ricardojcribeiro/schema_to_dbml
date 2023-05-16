# frozen_string_literal: true

require 'yaml'
require 'active_support/core_ext/hash'
require_relative 'configuration'
require_relative 'schema_to_dbml/build_dbml_content'
require_relative 'schema_to_dbml/errors/schema_file_not_found_error'
require_relative 'schema_to_dbml/errors/yaml_file_not_found_error'
require_relative 'schema_to_dbml/schema_converter'
require_relative 'schema_to_dbml/version'

class SchemaToDbml
  DEFAULT_CONFIG_FILE = File.join(__dir__, 'schema_to_dbml/configs/custom_config.yml')

  class << self
    def configuration
      @configuration ||= load_configuration_from_yaml(file_path: DEFAULT_CONFIG_FILE)
    end

    def load_configuration_from_yaml(file_path: DEFAULT_CONFIG_FILE)
      raise Errors::YamlFileNotFoundError, "#{file_path} not found" unless File.exist?(file_path)

      yaml_data = load_yaml(file_path)
      yaml_data = merge_with_defaults(yaml_data) if default_config?(file_path)

      configure_settings(Configuration.new, yaml_data)
    end

    private

    def load_yaml(file_path)
      YAML.load_file(file_path)
    end

    def merge_with_defaults(yaml_data)
      default_settings = load_yaml(DEFAULT_CONFIG_FILE)
      default_settings.deep_merge!(yaml_data)
    end

    def default_config?(file_path)
      file_path != DEFAULT_CONFIG_FILE
    end

    def configure_settings(config, yaml_data)
      config.tap do |c|
        c.custom_primary_key = yaml_data['custom_primary_key']
        c.custom_database_type = yaml_data['custom_database_type']
        c.custom_project_name = yaml_data['custom_project_name']
        c.custom_project_notes = yaml_data['custom_project_notes']
      end
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
