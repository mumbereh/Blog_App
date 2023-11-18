# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  layout 'standard'
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment created successfully!'
      redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
    else
      flash.now[:error] = 'Error: Comment could not be created!'
      render :new, locals: { comment: @comment }
    end
  end

  def edit
    # @comment is already loaded by the before_action
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'Comment updated successfully!'
      redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
    else
      flash.now[:error] = 'Error: Comment could not be updated!'
      render :edit, locals: { comment: @comment }
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted successfully!'
    redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize! params[:action].to_sym, @comment
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end