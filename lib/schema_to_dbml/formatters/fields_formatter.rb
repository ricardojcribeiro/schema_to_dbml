# frozen_string_literal: true

module Formatters
  module FieldsFormatter
    TYPE_MAPPER = {
      string: 'varchar',
      integer: 'int',
      boolean: 'bool',
      datetime: 'timestamp'
    }.freeze

    def format_type(type:, array:)
      return '' if type.to_s.empty?

      parsed = TYPE_MAPPER[type.to_sym] || type.to_s

      return "#{parsed}[]" if array == 'true'

      parsed
    end

    def format_default(default:)
      return '' if default.to_s.empty?

      "default: #{default}"
    end

    def format_null(null:)
      return '' if null.to_s.empty?

      'not null'
    end

    def format_comment(comment:)
      return '' if comment.to_s.empty?

      "note: '#{comment}'"
    end
  end
end
