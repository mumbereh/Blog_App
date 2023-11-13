class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new create]

  def index
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def like
    @post = Post.find(params[:id])
    if current_user.likes.exists?(post: @post)
      redirect_to @post, alert: 'You have already liked this post.'
    else
      current_user.likes.create(post: @post)
      redirect_to @post, notice: 'Post liked!'
    end
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post Created successfully'
    else
      puts @post.errors.full_messages
      render :new
    end
  end

  private

  def set_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  rescue ActiveRecord::RecordNotFound
    render plain: 'User not found', status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
