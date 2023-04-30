# frozen_string_literal: true

RSpec.describe DbmlRelationsFormatter do
  describe '#format' do
    it 'formats the relation string without on_delete option' do
      expect(subject.format(from_table: 'comments', to_table: 'posts', column: nil, on_delete: nil))
        .to eq('Ref fk_rails_comments_posts:comments.post_id - posts.id')
    end

    it 'formats the relation string with custom column' do
      expect(subject.format(from_table: 'posts', to_table: 'users', column: 'author_id', on_delete: nil))
        .to eq('Ref fk_rails_posts_users_author_id:posts.author_id - users.id')
    end

    it 'formats the relation string with on_delete option' do
      expect(subject.format(from_table: 'comments', to_table: 'posts', column: nil, on_delete: 'cascade'))
        .to eq('Ref fk_rails_comments_posts:comments.post_id - posts.id [delete: cascade]')
    end
  end
end
