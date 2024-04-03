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

# This will output the generated DBML content
dbml_content = SchemaToDbml.new.convert(schema: 'db/schema.rb')
puts dbml_content

# This will generate the file (db/schema.dbml) with the above content
SchemaToDbml.new.generate(schema: 'db/schema.rb')
```

## Custom Configuration

If you want to customize the DBML content, you can create a YAML configuration file with your desired properties.
By default, the SchemaToDbml will load the below default configuration

```yaml
custom_project_name: 'dbml_database_definition'
custom_database_type: "'PostgreSQL'"
custom_project_notes: |
  # My Project Notes
  This is a **project** that documents the database. Here are some key points:

  - Utilizes the custom primary key for better indexing
  - Specifies the appropriate database type (e.g., PostgreSQL)
  - Provides meaningful project information and descriptions
custom_primary_key: "id integer [pk, unique, note: '''Unique identifier and primary key''']"
custom_dbml_content: ''
custom_dbml_file_path: 'db/schema.dbml'
```

You can change the properties as you want. After that, you can load the configuration by calling:

```ruby
SchemaToDbml.load_configuration_from_yaml(file_path: '/path/to/your/custom_config.yml')
```

Example of custom yaml configurations:

```ruby
custom_database_type: 'PostgreSQL'
custom_project_name: 'my_project_database'
custom_project_notes: |
  # My Project Database
  This database is designed to support the operations of my project, a leading platform on my core business
custom_dbml_content: |
  enum object_status {
    created [note: 'Initial status']
    pending  
    finished
    cancelled
  }
  TableGroup my_table_group {
    table_1
    table_2
    table_3
  }
```

After that, you can use the SchemaToDbml to generate the DBML content as usual.

## Development


After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle install`.

For proposing changes, create a new branch and make your changes there. Do not change the version number in `version.rb`.  After you've done your changes, open a new Pull Request (PR) for your changes to be reviewed.

The maintainers will review your PR. If approved, they will update the version number in `version.rb` and run `bundle exec rake release`. This will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org/).

Remember, direct changes to the version number and releases are not allowed. All changes should go through a Pull Request and should be approved by the maintainers.

## Contributing

Please read the [contribution guideline](https://github.com/ricardojcribeiro/schema_to_dbml/blob/develop/CONTRIBUTE.md)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SchemaToDbml project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ricardojcribeiro/schema_to_dbml/blob/develop/CODE_OF_CONDUCT.md).
