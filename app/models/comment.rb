class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_comments_counter

  private

  def update_comments_counter
    post.update(commentsCounter: post.comments.count)
  end
end
