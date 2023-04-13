# # frozen_string_literal: true

# RSpec.describe SchemaToDbml do
#   let(:schema_converter) { double(:schema_converter) }
#   let(:schema_to_dbml) { SchemaToDbml.new(schema_converter:) }

#   describe '#convert' do
#     before do
#       stub_const('Rails', Class.new)
#       allow(Rails).to receive_message_chain(:root, :join).and_return('path_to_schema')
#     end

#     context 'when Rails and schema.rb are available' do
#       before do
#         allow(File).to receive(:read).and_return('schema_content')
#         allow(schema_converter).to receive(:convert).and_return('dbml_content')
#       end

#       it 'converts the schema to DBML' do
#         expect(schema_to_dbml.convert).to eq('dbml_content')
#         expect(schema_converter).to receive(:convert).with('schema_content')
#       end
#     end

#     context 'when Rails is not defined' do
#       it 'raises a MissingRailsError' do
#         expect { schema_to_dbml.convert }.to raise_error(SchemaToDbml::MissingRailsError)
#       end
#     end

#     context 'when schema.rb is not found' do
#       before do
#         allow(File).to receive(:read).and_raise(Errno::ENOENT)
#       end

#       it 'raises a SchemaFileNotFoundError' do
#         expect { schema_to_dbml.convert }.to raise_error(SchemaToDbml::SchemaFileNotFoundError)
#       end
#     end
#   end
# end
