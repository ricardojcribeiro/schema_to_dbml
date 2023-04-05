# frozen_string_literal: true

require_relative 'helpers/constants'

class SchemaConverter
  include Helpers::Constants

  def initialize(dbml_formatter: DbmlFormatter.new)
    @dbml_formatter = dbml_formatter
  end

  def convert(schema_file:)
    tables = []
    schema_file.scan(TABLES_REGEXP).each do |table_name, table_comment, columns|
      tables << dbml_formatter.format(table_name:, table_comment:, columns:)
    end
  end
end
