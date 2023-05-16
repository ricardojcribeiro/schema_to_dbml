# frozen_string_literal: true

RSpec.describe SchemaToDbml do
  include FinalDbmlContentSpecHelper

  describe '#convert' do
    let(:schema_path) { "#{EXAMPLES_PATH}/example_schema.rb" }
    let(:expected_dbml_content) { File.read("#{EXAMPLES_PATH}/example_schema.dbml") }
    let(:perform) { subject.convert(schema: schema_path) }

    context 'when schema file exists' do
      it 'returns the expected DBML content' do
        expect(perform).to eq(final_dbml_content)
      end
    end

    context 'when schema file does not exist' do
      let(:schema_path) { 'invalid_path' }

      it 'raises SchemaFileNotFoundError' do
        expect { perform[:tables] }.to raise_error(Errors::SchemaFileNotFoundError)
      end
    end
  end

  describe '.load_configuration_from_yaml' do
    let(:default_config_path) { SchemaToDbml::DEFAULT_CONFIG_FILE }
    let(:file_path) { nil }
    let(:config) { Configuration.new }
    let(:perform) { SchemaToDbml.load_configuration_from_yaml(file_path:) }

    context 'when custom configuration file is missing primary key' do
      let(:file_path) { "#{EXAMPLES_PATH}/custom_config_example.yml" }
      let(:expected_response) do
        {
          custom_primary_key: "id integer [pk, unique, note: 'Unique identifier and primary key']",
          custom_database_type: "'custom_database'",
          custom_project_name: 'custom_project_name',
          custom_project_notes: 'custom_notes'
        }
      end

      it 'uses default primary key' do
        expect(perform).to have_attributes(expected_response)
      end
    end

    context 'when no file path is given' do
      it 'loads the default configuration' do
        perform = SchemaToDbml.load_configuration_from_yaml
        expect(perform).to have_attributes(expected_default_response)
      end
    end

    context 'when configuration file does not exist' do
      let(:file_path) { 'invalid_path' }

      it 'raises FileNotFoundError' do
        expect { perform }.to raise_error(Errors::YamlFileNotFoundError)
      end
    end
  end
end
