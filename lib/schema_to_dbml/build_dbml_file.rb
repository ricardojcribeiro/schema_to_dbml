# frozen_string_literal: true

require_relative 'helpers/constants'
require_relative 'dbml_tables_formatter'
require_relative 'dbml_relations_formatter'

class SchemaConverter
  include Helpers::Constants

  def initialize(
    dbml_relations_formatter: DbmlRelationsFormatter.new,
    dbml_tables_formatter: DbmlTablesFormatter.new
  )
    @dbml_relations_formatter = dbml_relations_formatter
    @dbml_tables_formatter = dbml_tables_formatter
  end

  def convert(schema_content:)
    tables = []
    relations = []
    schema_content.scan(TABLES_REGEXP).each do |table_name, table_comment, table_attributes|
      tables << dbml_tables_formatter.format(table_name:, table_comment:, table_attributes:)
    end

    schema_content.scan(RELATIONS_REGEXP).each do |from_table, to_table, column, on_delete|
      relations << dbml_relations_formatter.format(from_table:, to_table:, column:, on_delete:)
    end

    { tables:, relations: }
  end

  private

  attr_reader :dbml_relations_formatter, :dbml_tables_formatter
end
