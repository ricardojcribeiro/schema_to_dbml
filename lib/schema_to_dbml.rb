# frozen_string_literal: true

require 'yaml'
require 'active_support/core_ext/hash'
require_relative 'configuration'
require_relative 'schema_to_dbml/build_dbml_content'
require_relative 'schema_to_dbml/errors/schema_file_not_found_error'
require_relative 'schema_to_dbml/errors/configuration_file_not_found_error'
require_relative 'schema_to_dbml/schema_converter'
require_relative 'schema_to_dbml/version'

class SchemaToDbml
  DEFAULT_CONFIG_FILE = File.join(__dir__, 'schema_to_dbml/configs/custom_config.yml')

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def load_configuration_from_yaml(file_path: DEFAULT_CONFIG_FILE)
      raise Errors::ConfigurationFileNotFoundError unless File.exist?(file_path)

      yaml_data = YAML.load_file(file_path)
      yaml_data = merge_with_defaults(file_path, yaml_data)

      configuration.configure_from_hash(yaml_data)
    end

    def merge_with_defaults(file_path, yaml_data)
      return yaml_data unless file_path != DEFAULT_CONFIG_FILE

      default_settings = YAML.load_file(DEFAULT_CONFIG_FILE)

      default_settings.deep_merge!(yaml_data)
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
