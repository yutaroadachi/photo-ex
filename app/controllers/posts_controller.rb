class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,       only: :destroy
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "展示が完了しました！"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "展示を取り下げました。"
    redirect_to request.referrer || root_url
  end
  
  private
    def post_params
      params.require(:post).permit(:photo, :title)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end