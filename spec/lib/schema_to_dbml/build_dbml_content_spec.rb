# frozen_string_literal: true

RSpec.describe BuildDbmlContent do
  let(:configuration) do
    instance_double(
      Configuration,
      custom_project_name: 'SampleProject',
      custom_database_type: 'PostgreSQL',
      custom_project_notes: 'This is a sample project.'
    )
  end

  let(:converted_data) do
    {
      tables: [
        "Table users {\n  id integer [pk, unique]\n  name varchar\n  email varchar\n}",
        "Table posts {\n  id integer [pk, unique]\n  title varchar\n  content text\n}"
      ],
      relations: [
        'Ref: users.id < posts.user_id'
      ]
    }
  end

  subject { described_class.new(configuration:) }
  let(:perform) { subject.build(converted: converted_data) }

  describe '#build' do
    it 'returns a string' do
      expect(perform).to be_a(String)
    end

    it 'includes the project header' do
      expect(perform).to include("Project #{configuration.custom_project_name}")
      expect(perform).to include("database_type: #{configuration.custom_database_type}")
      expect(perform).to include("Note: '#{configuration.custom_project_notes}'")
    end

    it 'includes the tables section' do
      expect(perform).to include('Table users')
      expect(perform).to include('Table posts')
    end

    it 'includes the relations section' do
      expect(perform).to include('Ref: users.id < posts.user_id')
    end
  end
end
