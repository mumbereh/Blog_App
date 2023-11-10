class PostsController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts.paginate(page: params[:page], per_page: 2) if @user
  end

  def show; end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
