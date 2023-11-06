require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      user = User.new(name: 'John Doe', posts_counter: 3)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a negative posts_counter' do
      user = User.new(name: 'Alice', posts_counter: -1)
      expect(user).to_not be_valid
    end
  end
  describe '#recent_posts' do
    it 'should display the 3 last recents posts' do
      author_object = User.new(name: 'Ariel_CEO')
      author_object.posts_counter = 0
      author_object.save
      user = User.new(name: 'Ariel_CEO')
      user.posts_counter = 0
      user.save
      post1 = Post.new(title: 'Microverse School')
      post1.author_id = user.id
      post1.text = 'I love Microverse'
      post1.comments_counter = 0
      post1.likes_counter = 0
      post1.save
      post2 = Post.new(title: 'Microverse School')
      post2.author_id = user.id
      post2.text = 'I love Microverse'
      post2.comments_counter = 0
      post2.likes_counter = 0
      post2.save
      post3 = Post.new(title: 'Microverse School')
      post3.author_id = user.id
      post3.text = 'I love Microverse'
      post3.comments_counter = 0
      post3.likes_counter = 0
      post3.save
      posts_number = user.user_recent_posts
      expect(posts_number.count).to eq(3)
    end
  end
end
