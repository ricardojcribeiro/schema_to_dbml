# frozen_string_literal: true

require_relative 'formatters/fields_formatter'
require_relative 'helpers/constants'

class DbmlTablesFormatter
  include Helpers::Constants
  include Formatters::FieldsFormatter

  def initialize(configuration: SchemaToDbml.configuration)
    @configuration = configuration
  end

  def format(table_name:, table_comment:, parsed_columns:)
    columns = build_columns(parsed_columns)

    format_dbml(table_name, columns, table_comment)
  end

  private

  def build_columns(parsed_columns)
    columns = []

    parsed_columns.scan(COLUMNS_REGEXP).each do |type, name, default, null, comment, _precision, array, limit|
      formatted_comment = format_comment(comment:)
      formatted_default = format_default(default:)
      formatted_null = format_null(null:)
      formatted_type = format_type(type:, array:, limit:)

      final_values = [formatted_default, formatted_null, formatted_comment].compact.reject(&:empty?)
      columns << build_line(name, formatted_type, final_values)
    end

    columns
  end

  def build_line(name, formatted_type, final_values)
    line = "  #{name} #{formatted_type}"

    return line if final_values.empty?

    line << " [#{final_values.join(',')}]"
  end

  def format_dbml(table_name, columns, table_comment)
    dbml_table = "Table #{table_name} {\n"
    dbml_table << "  #{custom_primary_key}\n"
    dbml_table << columns.join("\n")
    dbml_table << "\n  Note: '#{table_comment}'" unless table_comment.to_s.empty?
    dbml_table << "\n  Tada: '#{table_comment}'" if table_comment == 'tada'
    dbml_table << "\n}"
    dbml_table
  end

  def custom_primary_key
    configuration.custom_primary_key
  end

  attr_reader :configuration
end
