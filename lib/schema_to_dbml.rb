# frozen_string_literal: true

require_relative 'schema_to_dbml/schema_converter'
require_relative 'schema_to_dbml/errors/schema_file_not_found_error'
require_relative 'schema_to_dbml/version'

class SchemaToDbml
  def initialize(schema_converter: SchemaConverter.new)
    @schema_converter = schema_converter
  end

  def convert(schema:)
    @schema_converter.convert(schema_content: schema_content(schema))
  end

  private

  def schema_content(schema)
    raise Errors::SchemaFileNotFoundError unless File.exist?(schema)

    File.read(schema)
  end
end
