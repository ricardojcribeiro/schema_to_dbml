# frozen_string_literal: true

require_relative 'schema_to_dbml/fields_formatter'
require_relative 'helpers/constants'

class DbmlFormatter
  include Formatters::FieldsFormatter
  include Helpers::Constants

  def format(table_name:, table_comment:, columns:)
    columns = []
    parsed_columns.scan(COLUMNS_REGEXP).each do |type, name, default, null, comment, array|
      formatted_type = format_type(value: type, array:)
      formatted_default = format_default(default:)
      formatted_comment = format_comment(comment:)

      final_values = [formatted_type, formatted_default, null, formatted_comment]

      columns << "#{name} #{formatted_type} [#{final_values.join(',')}]"
    end

    dbml_table = "Table #{table_name} {\n"
    dbml_table << columns.join('\n').to_s
    dbml_table << "Note: '#{table_comment}'" unless table_comment.blank?
    dbml_table << "\n}"
    dbml_table
  end
end
