# frozen_string_literal: true

RSpec.describe SchemaToDbml do
  include FinalDbmlContentSpecHelper
  include DbmlCustomContentSpecHelper

  rollback_config

  describe '#convert' do
    let(:schema_path) { "#{SUPPORT_FILES_PATH}/example_schema.rb" }
    let(:perform) { subject.convert(schema: schema_path) }

    before { load_custom_config }

    context 'when schema file exists' do
      it 'returns the expected DBML content' do
        expect(perform).to eq(final_dbml_content)
      end
    end

    context 'when schema file does not exist' do
      let(:schema_path) { 'invalid_path' }

      it 'raises SchemaFileNotFoundError' do
        expect { perform }.to raise_error(Errors::SchemaFileNotFoundError)
      end
    end
  end

  describe '#generate' do
    let(:schema_path) { "#{SUPPORT_FILES_PATH}/example_schema.rb" }
    let(:perform) { subject.generate(schema: schema_path) }

    before { load_custom_config }

    context 'when schema file exists' do
      let(:dbml_file_path) { 'generated.dbml' }

      before do
        described_class.configuration.custom_dbml_file_path = dbml_file_path
      end

      after { FileUtils.rm_rf(dbml_file_path) }

      it 'creates expected DBML file' do
        perform

        expect(FileUtils.compare_file(dbml_file_path, "#{SUPPORT_FILES_PATH}/example_final_dbml_content.dbml")).to be(true)
      end
    end

    context 'when schema file does not exist' do
      let(:schema_path) { 'invalid_path' }

      it 'raises SchemaFileNotFoundError' do
        expect { perform }.to raise_error(Errors::SchemaFileNotFoundError)
      end
    end
  end

  describe '.load_configuration_from_yaml' do
    let(:perform) { load_custom_config }

    context 'when custom configuration file is missing primary key' do
      let(:expected_response) do
        {
          custom_primary_key: "id integer [pk, unique, note: '''Unique identifier and primary key''']",
          custom_database_type: 'custom_database',
          custom_project_name: 'custom_project_name',
          custom_project_notes: 'custom_notes'
        }
      end

      it 'uses default primary key' do
        perform

        expect(described_class.configuration).to have_attributes(expected_response)
      end
    end

    context 'when no file path is given' do
      let(:perform) { load_default_config }

      it 'loads the default configuration' do
        perform

        expect(described_class.configuration).to have_attributes(expected_default_response)
      end
    end

    context 'when configuration file does not exist' do
      let(:custom_config_path) { 'invalid_path' }

      it 'raises FileNotFoundError' do
        expect { perform }.to raise_error(Errors::ConfigurationFileNotFoundError)
      end
    end
  end
end
