# frozen_string_literal: true

RSpec.describe BuildDbmlContent do
  subject { described_class.new(configuration:) }

  let(:configuration) do
    instance_double(
      Configuration,
      custom_project_name: 'TestProject',
      custom_database_type: 'PostgreSQL',
      custom_project_notes: 'TestNotes',
      custom_dbml_content:
    )
  end
  let(:perform) { subject.build(converted:) }
  let(:converted) do
    {
      tables: ['Table users { id integer [pk] name varchar }'],
      relations: ['Ref: users.id < orders.user_id']
    }
  end
  let(:custom_dbml_content) do
    "enum object_status {
      created [note: '''Waiting to be processed''']
      running
      done
      failure
    }"
  end

  describe '#build' do
    let(:expected_dbml_content) do
      [
        "Project TestProject {\n  database_type: 'PostgreSQL'\n  Note: '''TestNotes'''\n}",
        'Table users { id integer [pk] name varchar }',
        'Ref: users.id < orders.user_id',
        custom_dbml_content
      ].join("\n\n")
    end

    it 'returns the expected DBML content' do
      expect(perform).to eq(expected_dbml_content)
    end
  end
end
