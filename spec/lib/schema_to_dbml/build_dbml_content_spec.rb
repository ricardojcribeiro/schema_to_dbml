# frozen_string_literal: true

RSpec.describe BuildDbmlContent do
  let(:configuration) do
    instance_double(
      Configuration,
      custom_project_name: 'TestProject',
      custom_database_type: 'PostgreSQL',
      custom_project_notes: 'TestNotes',
      custom_dbml_content:
    )
  end
  let(:converted) do
    {
      tables: ['Table users { id integer [pk] name varchar }'],
      relations: ['Ref: users.id < orders.user_id']
    }
  end
  let(:custom_dbml_content) do
    "enum object_status {
      created [note: 'Waiting to be processed']
      running
      done
      failure
    }"
  end

  subject { described_class.new(configuration:) }
  let(:perform) { subject.build(converted:) }

  describe '#build' do
    it 'returns the expected DBML content' do
      expected_dbml_content = [
        "Project TestProject {\n  database_type: PostgreSQL\n  Note: 'TestNotes'\n}",
        'Table users { id integer [pk] name varchar }',
        'Ref: users.id < orders.user_id',
        custom_dbml_content
      ].join("\n\n")

      expect(perform).to eq(expected_dbml_content)
    end
  end
end
