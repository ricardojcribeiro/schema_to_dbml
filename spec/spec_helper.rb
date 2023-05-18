# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'byebug'
require 'schema_to_dbml'
require_relative '../lib/schema_to_dbml/errors/schema_file_not_found_error'
require_relative '../lib/schema_to_dbml/errors/configuration_file_not_found_error'
require_relative '../spec/lib/schema_to_dbml/support/schema_converter_spec_helper'
require_relative '../spec/lib/schema_to_dbml/support/constants_spec_helper'
require_relative '../spec/lib/schema_to_dbml/support/final_dbml_content_spec_helper'

EXAMPLES_PATH = File.join(File.dirname(__FILE__), 'shared_examples')

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
