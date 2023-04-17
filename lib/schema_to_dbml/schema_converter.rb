# frozen_string_literal: true

require_relative 'helpers/constants'
require_relative './dbml_formatter'

class SchemaConverter
  include Helpers::Constants

  def initialize(dbml_formatter: DbmlFormatter.new)
    @dbml_formatter = dbml_formatter
  end

  def convert(schema_content:)
    tables = []
    schema_content.scan(TABLES_REGEXP).each do |table_name, table_comment, columns|
      tables << dbml_formatter.format(table_name:, table_comment:, parsed_columns: columns)
    end

    tables
  end

  private

  attr_reader :dbml_formatter
end
