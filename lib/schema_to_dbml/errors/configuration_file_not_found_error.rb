# frozen_string_literal: true

module Errors
  class ConfigurationFileNotFoundError < StandardError
    def initialize(message = 'Configuration file was not found')
      super
    end
  end
end
