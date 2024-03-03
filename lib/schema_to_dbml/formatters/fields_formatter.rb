# frozen_string_literal: true

require_relative 'default_field_formatter_helper'

module Formatters
  module FieldsFormatter
    include DefaultFieldFormatterHelper

    COMMENT_MAPPER = [
      { from: "'", to: "\\\\'" },
      { from: '\"', to: '"' }
    ].freeze
    TYPE_MAPPER = {
      string: 'varchar',
      integer: 'int',
      boolean: 'bool',
      datetime: 'timestamp'
    }.freeze

    def format_type(type:, array:, limit:)
      return '' if type.to_s.empty?

      parsed = TYPE_MAPPER[type.to_sym] || type.to_s

      return "#{parsed}[]" if array == 'true'
      return "#{parsed}(#{limit})" if limit

      parsed
    end

    def format_default(default:)
      return '' if default.to_s.empty?

      DEFAULT_PATTERNS.each do |pattern, replacement|
        default = default.gsub(pattern, replacement)
      end

      default
    end

    def format_null(null:)
      return '' if null.to_s.empty?

      'not null'
    end

    def format_comment(comment:)
      return '' if comment.to_s.empty?

      note = comment.dup
      COMMENT_MAPPER.each do |mapper|
        note.gsub!(mapper[:from], mapper[:to])
      end

      "note: '#{note}'"
    end
  end
end
