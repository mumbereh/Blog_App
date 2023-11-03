class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :comments
  has_many :likes

  after_create :update_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    user.update(postsCounter: user.posts.count)
  end
end
