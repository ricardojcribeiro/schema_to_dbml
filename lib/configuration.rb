# frozen_string_literal: true

class Configuration
  attr_accessor :custom_primary_key

  def initialize
    @custom_primary_key = ''
  end
end
