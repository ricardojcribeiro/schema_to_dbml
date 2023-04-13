# frozen_string_literal: true

module Errors
  class SchemaFileNotFoundError < StandardError
    def initialize(message = 'schema.rb file not found.')
      super
    end
  end
end
