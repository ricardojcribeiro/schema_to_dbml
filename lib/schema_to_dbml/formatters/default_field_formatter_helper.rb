# frozen_string_literal: true

module DefaultFieldFormatterHelper
  DEFAULT_ARRAY_REGEX = [/default: (\[.*?\])/, 'default: \'\1\''].freeze
  DEFAULT_BOOLEAN_REGEX = [/default: (true|false)/, 'default: \1'].freeze
  DEFAULT_HASH_REGEX = [/default: (\{(?:[^}]*?)\})/, 'default: \'\1\''].freeze
  DEFAULT_NUMBER_REGEX = [/default: (\d+(?:\.\d+)?)/, 'default: \1'].freeze
  DEFAULT_STRING_REGEX = [/default: "(.*?)"/, 'default: \'\1\''].freeze
  DEFAULT_LAMBDA_REGEX = [/default: -> \{ "(.*?)" \}/, 'default: `\1`'].freeze

  DEFAULT_PATTERNS = [
    DEFAULT_ARRAY_REGEX,
    DEFAULT_BOOLEAN_REGEX,
    DEFAULT_HASH_REGEX,
    DEFAULT_NUMBER_REGEX,
    DEFAULT_STRING_REGEX,
    DEFAULT_LAMBDA_REGEX
  ].freeze
end
