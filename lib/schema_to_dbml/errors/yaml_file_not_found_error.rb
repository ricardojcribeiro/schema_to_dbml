# frozen_string_literal: true

module Errors
  class YamlFileNotFoundError < StandardError
    def initialize(message = 'Yaml file was not found')
      super
    end
  end
end
