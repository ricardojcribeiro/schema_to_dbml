# frozen_string_literal: true

require_relative 'formatters/fields_formatter'
require_relative 'helpers/constants'

class DbmlTablesFormatter
  include Helpers::Constants
  include Formatters::FieldsFormatter

  def format(table_name:, table_comment:, parsed_columns:)
    columns = build_columns(parsed_columns)

    format_dbml(table_name, columns, table_comment)
  end

  private

  def build_columns(parsed_columns)
    columns = []

    parsed_columns.scan(COLUMNS_REGEXP).each do |type, name, default, null, comment, _precision, array|
      formatted_comment = format_comment(comment:)
      formatted_default = format_default(default:)
      formatted_null = format_null(null:)
      formatted_type = format_type(type:, array:)

      final_values = [formatted_default, formatted_null, formatted_comment].compact.reject(&:empty?)
      columns << "  #{name} #{formatted_type} [#{final_values.join(',')}]"
    end

    columns
  end

  def format_dbml(table_name, columns, table_comment)
    dbml_table = "Table #{table_name} {\n"
    dbml_table << "  #{default_primary_key}\n"
    dbml_table << columns.join("\n")
    dbml_table << "\n  Note: '#{table_comment}'" unless table_comment.to_s.empty?
    dbml_table << "\n}"
    dbml_table
  end

  def default_primary_key
    custom_primary_key = SchemaToDbml.configuration.custom_primary_key

    return custom_primary_key unless custom_primary_key.to_s.empty?

    DEFAULT_PRIMARY_KEY
  end
end
