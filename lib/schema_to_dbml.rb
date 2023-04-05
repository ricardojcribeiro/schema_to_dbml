# frozen_string_literal: true

require_relative 'schema_to_dbml/version'
require_relative 'schema_to_dbml/schema_converter'

class SchemaToDbml
  def initialize(schema_converter: SchemaConverter.new)
    @schema_converter = schema_converter
  end

  def convert
    @schema_converter.convert(schema:)
  end

  private

  def schema
    raise MissingRailsError unless Kernel.const_defined? 'Rails'

    File.read(File.join(Rails.root, 'db', 'schema.rb'))
  rescue Errno::ENOENT
    raise SchemaFileNotFoundError
  end
end
