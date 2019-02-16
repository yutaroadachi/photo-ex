class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @q = User.ransack(params[:q])
    if @q
      @users = @q.result(distinct: true).page(params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end