# # frozen_string_literal: true

# RSpec.describe SchemaConverter do
#   let(:dbml_formatter) { DbmlFormatter.new }
#   let(:schema_converter) { SchemaConverter.new(dbml_formatter:) }

#   it 'includes Constants' do
#     expect(described_class.ancestors).to include(Helpers::Constants)
#   end

#   describe '#convert' do
#     let(:file) { EXAMPLES_PATH }
#     let(:schema_file) { File.read("#{EXAMPLES_PATH}/example_schema.rb") }

#     let(:perform) { schema_converter.convert(schema_file:) }

#     # before do
#     #   allow(dbml_formatter).to receive(:format)
#     #     .with(table_name: 'users', table_comment: 'Represents a user who can create blog posts and comments', parsed_columns: anything)
#     #     .and_return(formatted_users_table)

#     #   allow(dbml_formatter).to receive(:format)
#     #     .with(table_name: 'posts', table_comment: 'Represents a blog post created by a user', parsed_columns: anything)
#     #     .and_return(formatted_posts_table)
#     # end

#     it 'converts the schema file into a list of formatted DBML tables' do
#       byebug
#       expect(perform).to eq('')
#     end
#   end
# end
