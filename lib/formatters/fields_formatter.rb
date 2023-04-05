# frozen_string_literal: true

module Formatters
  module FieldsFormatter
    def format_type(value:, array:)
      return if value.nil?

      parsed = case value.to_sym
               when :string
                 "#{name} varchar"
               when :integer
                 "#{name} int"
               when :boolean
                 "#{name} bool"
               when :datetime
                 "#{name} timestamp"
               else
                 "#{name} #{type}"
               end

      "#{parsed}[]" if array
    end

    def format_default(default:)
      return '' if default.blank?

      "default: #{default}"
    end

    def format_comment(comment)
      return '' if comment.blank?

      "note: #{comment}"
    end
  end
end
