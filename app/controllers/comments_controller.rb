class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = Post.find(params[:post_id])

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      render 'new'
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
