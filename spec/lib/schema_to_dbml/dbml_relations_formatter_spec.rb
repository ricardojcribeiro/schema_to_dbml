# frozen_string_literal: true

RSpec.describe DbmlRelationsFormatter do
  describe '#format' do
    let(:formatter) { described_class.new }

    it 'formats the relation string without on_delete option' do
      expect(formatter.format(from_table: 'comments', to_table: 'posts', column: nil, on_delete: nil))
        .to eq('Ref fk_rails_comments_posts:comments.post_id - posts.id')
    end

    it 'formats the relation string with custom column' do
      expect(formatter.format(from_table: 'posts', to_table: 'users', column: 'author_id', on_delete: nil))
        .to eq('Ref fk_rails_posts_users_author_id:posts.author_id - users.id')
    end

    it 'formats the relation string with on_delete cascade option' do
      expect(formatter.format(from_table: 'comments', to_table: 'posts', column: nil, on_delete: 'cascade'))
        .to eq('Ref fk_rails_comments_posts:comments.post_id - posts.id [delete: cascade]')
    end

    it 'formats the relation string with on_delete nullify option' do
      expect(formatter.format(from_table: 'comments', to_table: 'posts', column: nil, on_delete: 'nullify'))
        .to eq('Ref fk_rails_comments_posts:comments.post_id - posts.id [delete: set null]')
    end
  end
end
