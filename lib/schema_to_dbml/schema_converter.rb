# frozen_string_literal: true

require_relative 'helpers/constants'
require_relative './dbml_tables_formatter'

class SchemaConverter
  include Helpers::Constants

  def initialize(dbml_tables_formatter: DbmlTablesFormatter.new)
    @dbml_tables_formatter = dbml_tables_formatter
  end

  def convert(schema_content:)
    tables = []
    schema_content.scan(TABLES_REGEXP).each do |table_name, table_comment, columns|
      tables << dbml_tables_formatter.format(table_name:, table_comment:, parsed_columns: columns)
    end

    tables
  end

  private

  attr_reader :dbml_tables_formatter
end
