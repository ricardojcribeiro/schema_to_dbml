# frozen_string_literal: true

require_relative 'formatters/fields_formatter'
require_relative 'helpers/constants'

class DbmlFormatter
  include Helpers::Constants
  include Formatters::FieldsFormatter

  def format(table_name:, table_comment:, parsed_columns:)
    columns = []
    parsed_columns.scan(COLUMNS_REGEXP).each do |type, name, default, null, comment, _precision, array|
      formatted_comment = format_comment(comment:)
      formatted_default = format_default(default:)
      formatted_null = format_null(null:)
      formatted_type = format_type(type:, array:)

      final_values = [formatted_default, formatted_null, formatted_comment]
      columns << "  #{name} #{formatted_type} [#{final_values.reject { |v| v.nil? || v.empty? }.join(',')}]"
    end

    dbml_table = "Table #{table_name} {\n"
    dbml_table << columns.join("\n").to_s
    dbml_table << "\n  Note: '#{table_comment}'" unless table_comment.to_s.empty?
    dbml_table << "\n}"
    dbml_table
  end
end
