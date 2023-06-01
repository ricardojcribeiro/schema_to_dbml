# frozen_string_literal: true

RSpec.describe Configuration do
  describe 'attributes' do
    it { is_expected.to respond_to(:custom_database_type) }
    it { is_expected.to respond_to(:custom_dbml_content) }
    it { is_expected.to respond_to(:custom_dbml_content) }
    it { is_expected.to respond_to(:custom_dbml_file_path) }
    it { is_expected.to respond_to(:custom_primary_key) }
    it { is_expected.to respond_to(:custom_project_name) }
    it { is_expected.to respond_to(:custom_project_notes) }
  end

  describe 'default values' do
    it 'has a default value of nil for custom_primary_key' do
      expect(subject.custom_primary_key).to be_nil
    end

    it 'has a default value of nil for custom_database_type' do
      expect(subject.custom_database_type).to be_nil
    end

    it 'has a default value of nil for custom_project_name' do
      expect(subject.custom_project_name).to be_nil
    end

    it 'has a default value of nil for custom_project_notes' do
      expect(subject.custom_project_notes).to be_nil
    end

    it 'has a default value of nil for custom_dbml_content' do
      expect(subject.custom_dbml_content).to be_nil
    end

    it 'has a default value of nil for custom_dbml_file_path' do
      expect(subject.custom_dbml_file_path).to be_nil
    end
  end

  describe 'setting attributes' do
    it 'can set custom_primary_key' do
      subject.custom_primary_key = 'pk_id'
      expect(subject.custom_primary_key).to eq('pk_id')
    end

    it 'can set custom_database_type' do
      subject.custom_database_type = 'PostgreSQL'
      expect(subject.custom_database_type).to eq('PostgreSQL')
    end

    it 'can set custom_project_name' do
      subject.custom_project_name = 'MyDatabase'
      expect(subject.custom_project_name).to eq('MyDatabase')
    end

    it 'can set custom_project_notes' do
      subject.custom_project_notes = 'My project notes'
      expect(subject.custom_project_notes).to eq('My project notes')
    end

    it 'can set custom_dbml_content' do
      subject.custom_dbml_content = 'My custom DBML content'
      expect(subject.custom_dbml_content).to eq('My custom DBML content')
    end

    it 'can set custom_dbml_file_path' do
      subject.custom_dbml_file_path = 'my/path.dbml'
      expect(subject.custom_dbml_file_path).to eq('my/path.dbml')
    end
  end
end
