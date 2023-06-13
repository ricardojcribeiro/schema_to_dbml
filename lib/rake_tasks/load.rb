# frozen_string_literal: true

require 'rake'

Dir[File.join(File.dirname(__FILE__), '**/*.rake')].each do |rake|
  load rake
end
