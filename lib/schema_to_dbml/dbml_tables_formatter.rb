# frozen_string_literal: true

require_relative 'formatters/fields_formatter'
require_relative 'formatters/index_formatter'
require_relative 'helpers/constants'

class DbmlTablesFormatter
  include Helpers::Constants
  include Formatters::FieldsFormatter
  include Formatters::IndexFormatter

  def initialize(configuration: SchemaToDbml.configuration)
    @configuration = configuration
  end

  def format(table_name:, table_comment:, table_attributes:)
    columns = build_columns(table_name, table_attributes)
    indexes = build_indexes(table_attributes)

    format_dbml(table_name, columns, indexes, table_comment)
  end

  private

  def build_columns(table_name, table_attributes)
    columns = []

    table_attributes.scan(COLUMNS_REGEXP).each do |type, name, default, null, comment, _precision, array, limit|
      formatted_comment = format_comment(comment:)
      formatted_default = format_default(default:)
      formatted_null = format_null(null:)
      custom_type = configuration.custom_tables&.dig(table_name, 'attributes', name, 'type')
      formatted_type = format_type(type: custom_type || type, array:, limit:)

      final_values = [formatted_default, formatted_null, formatted_comment].compact.reject(&:empty?)
      columns << build_line(name, formatted_type, final_values)
    end

    columns
  end

  def build_indexes(table_definition)
    indexes = []

    table_definition.scan(INDEXES_REGEXP) do |columns, index_name, unique|
      indexes << format_index(columns, index_name, unique)
    end

    return if indexes.empty?

    "\n#{TAB}indexes {\n#{indexes.join("\n")}\n#{TAB}}"
  end

  def build_line(name, formatted_type, final_values)
    line = "  #{name} #{formatted_type}"

    return line if final_values.empty?

    line << " [#{final_values.join(',')}]"
  end

  def format_dbml(table_name, columns, indexes, table_comment)
    dbml_table = "Table #{table_name} {\n"
    dbml_table << "#{TAB}#{custom_primary_key}\n"
    dbml_table << columns.join("\n")
    dbml_table << indexes if indexes
    dbml_table << "\n#{TAB}Note: '#{table_comment}'" unless table_comment.to_s.empty?
    dbml_table << "\n}"
    dbml_table
  end

  def custom_primary_key
    configuration.custom_primary_key
  end

  attr_reader :configuration
end
