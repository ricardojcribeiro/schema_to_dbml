# frozen_string_literal: true

namespace :schema_to_dbml do
  desc 'Build dbml.yml'
  task :generate, [:schema_path] do |_t, args|
    schema = args[:schema_path]
    raise 'Schema path must be provided' unless schema

    SchemaToDbml.load_configuration_from_yaml
    SchemaToDbml.new.generate(schema:)
  end
end
