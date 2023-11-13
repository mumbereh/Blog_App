class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user.increment!(:posts_counter)
    @recent_posts = @user.recent_posts(3)
  rescue ActiveRecord::RecordNotFound
    render plain: 'User not found', status: :not_found
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: 'User not found', status: :not_found
  end
end
