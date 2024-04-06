# frozen_string_literal: true

RSpec.describe 'schema_to_dbml' do
  before do
    Rake::Task.define_task(:environment)
  end

  describe '#generate' do
    let(:schema_instance) { instance_double(SchemaToDbml, generate: 'OK') }
    let(:file_path) { '/path/to/schema.rb' }
    let(:task) { Rake::Task['schema_to_dbml:generate'] }
    let(:perform) { task.invoke(file_path) }

    it 'delegates proper parameters to SchemaToDbml' do
      expect(SchemaToDbml)
        .to receive(:new)
        .and_return(schema_instance)

      expect(schema_instance)
        .to receive(:generate)
        .with(schema: file_path)

      perform
    end
  end
end
