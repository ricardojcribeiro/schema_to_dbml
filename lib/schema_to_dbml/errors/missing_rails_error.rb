# frozen_string_literal: true

module Errors
  class MissingRailsError < StandardError
    def initialize(message = 'Rails is mandatory to run this gem.')
      super
    end
  end
end
