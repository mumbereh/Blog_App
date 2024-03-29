class PostsController < ApplicationController
  layout 'standard'

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(id: :asc).paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_post_url(current_user, @post)
    else
      flash.now[:error] = 'Error: Post could not be created!'
      render :new, locals: { post: @post }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
