# frozen_string_literal: true

require_relative 'lib/schema_to_dbml/version'

Gem::Specification.new do |spec|
  spec.name = 'schema_to_dbml'
  spec.version = SchemaToDbml::VERSION
  spec.authors = ['Ricardo Ribeiro']
  spec.email = ['ricardo.costa.ribeiro@gmail.com']

  spec.summary = 'A Ruby on Rails gem for converting schema.rb files to DBML.'
  spec.description = 'This gem provides functionality for parsing a Rails schema.rb file and generating a corresponding DBML file.'
  spec.homepage = 'https://github.com/ricardojcribeiro/schema_to_dbml'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ricardojcribeiro/schema_to_dbml'
  spec.metadata['changelog_uri'] = 'https://github.com/ricardojcribeiro/schema_to_dbml/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'simplecov'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
