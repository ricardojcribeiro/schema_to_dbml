# SchemaToDbml

SchemaToDbml is a gem that generates a DBML (Database Markup Language) content from a Rails application schema.rb file. With SchemaToDbml, you can easily visualize your application's database schema in a clean and organized way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schema_to_dbml'
```

And then execute:

```ruby
$ bundle install
```

```ruby
$ gem install schema_to_dbml
```

## Usage

To use the SchemaToDbml, first, create a schema.rb file for your Rails application by running:

```ruby
$ rails db:schema:dump
```
Then, you can use the SchemaToDbml to generate a DBML content from the schema.rb file:

```ruby
require 'schema_to_dbml'

# Load configuration from default file
SchemaToDbml.configuration

dbml_content = SchemaToDbml.new.convert(schema: 'db/schema.rb')
puts dbml_content
```

This will output the generated DBML content.

## Custom Configuration

If you want to customize the DBML content, you can create a YAML configuration file with your desired properties.
By default, the SchemaToDbml will try to load the configuration from `schema_to_dbml/configs/custom_config.yml`.

Here's an example of the configuration file:

```yaml
custom_project_name: 'My Project'
custom_database_type: 'PostgreSQL'
custom_project_notes: 'This is my project.'
custom_primary_key: 'id [pk]'
```

You can change the properties as you want. After that, you can load the configuration by calling:

```ruby
SchemaToDbml.load_configuration_from_yaml('/path/to/your/custom_config.yml')
```

Or you can pass the configuration directly:

```ruby
config = Configuration.new
config.custom_project_name = 'My Project'
config.custom_database_type = 'PostgreSQL'
config.custom_project_notes = 'This is my project.'
config.custom_primary_key = 'id'

SchemaToDbml.configure(config)
```

After that, you can use the SchemaToDbml to generate the DBML content as usual.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Please read the [contribution guideline](https://github.com/ricardojcribeiro/schema_to_dbml/blob/develop/CONTRIBUTE.md)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SchemaToDbml project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/schema_to_dbml/blob/main/CODE_OF_CONDUCT.md).
