# frozen_string_literal: true

namespace :schema_to_dbml do
  desc 'build dmbl.yml'
  task :generate, %i[schema_path] => [:environment] do |_t, args|
    schema = args[:schema_path]
    SchemaToDbml.new.convert(schema:)
  end
end
