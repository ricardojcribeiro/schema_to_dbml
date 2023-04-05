# frozen_string_literal: true

class MissingRailsError < StandardError
  def initialize(message = 'Rails is mandatory to run this gem.')
    super
  end
end
