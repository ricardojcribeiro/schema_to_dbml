# frozen_string_literal: true

RSpec.describe Configuration do
  subject(:configuration) { described_class.new }

  describe 'attributes' do
    it { is_expected.to respond_to(:custom_database_type) }
    it { is_expected.to respond_to(:custom_dbml_content) }
    it { is_expected.to respond_to(:custom_dbml_file_path) }
    it { is_expected.to respond_to(:custom_primary_key) }
    it { is_expected.to respond_to(:custom_project_name) }
    it { is_expected.to respond_to(:custom_project_notes) }
    it { is_expected.to respond_to(:custom_tables) }
  end

  describe 'default values' do
    it 'has a default value of nil for custom_primary_key' do
      expect(configuration.custom_primary_key).to be_nil
    end

    it 'has a default value of nil for custom_database_type' do
      expect(configuration.custom_database_type).to be_nil
    end

    it 'has a default value of nil for custom_project_name' do
      expect(configuration.custom_project_name).to be_nil
    end

    it 'has a default value of nil for custom_project_notes' do
      expect(configuration.custom_project_notes).to be_nil
    end

    it 'has a default value of nil for custom_dbml_content' do
      expect(configuration.custom_dbml_content).to be_nil
    end

    it 'has a default value of nil for custom_dbml_file_path' do
      expect(configuration.custom_dbml_file_path).to be_nil
    end
  end

  describe 'setting attributes' do
    it 'can set custom_primary_key' do
      configuration.custom_primary_key = 'pk_id'
      expect(configuration.custom_primary_key).to eq('pk_id')
    end

    it 'can set custom_database_type' do
      configuration.custom_database_type = 'PostgreSQL'
      expect(configuration.custom_database_type).to eq('PostgreSQL')
    end

    it 'can set custom_project_name' do
      configuration.custom_project_name = 'MyDatabase'
      expect(configuration.custom_project_name).to eq('MyDatabase')
    end

    it 'can set custom_project_notes' do
      configuration.custom_project_notes = 'My project notes'
      expect(configuration.custom_project_notes).to eq('My project notes')
    end

    it 'can set custom_dbml_content' do
      configuration.custom_dbml_content = 'My custom DBML content'
      expect(configuration.custom_dbml_content).to eq('My custom DBML content')
    end

    it 'can set custom_dbml_file_path' do
      configuration.custom_dbml_file_path = 'my/path.dbml'
      expect(configuration.custom_dbml_file_path).to eq('my/path.dbml')
    end

    it 'can set custom_tables' do
      configuration.custom_tables = 'custom-table'
      expect(configuration.custom_tables).to eq('custom-table')
    end
  end
end
