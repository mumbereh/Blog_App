# app/models/user.rb

class User < ApplicationRecord
  # Devise modules including :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Associations
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  # Validations
  validates :name, presence: true
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Custom method to retrieve three most recent posts
  def three_recent_posts
    posts.order(created_at: :desc).first(3)
  end
end
