# frozen_string_literal: true

require_relative 'schema_to_dbml/schema_converter'
require_relative 'schema_to_dbml/errors/missing_rails_error'
require_relative 'schema_to_dbml/errors/schema_file_not_found_error'
require_relative 'schema_to_dbml/version'

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
