class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,       only: :destroy
  
  def index
    @q = Post.ransack(params[:q])
    if @q
      @posts = @q.result(distinct: true).page(params[:page])
    else
      @posts = Post.paginate(page: params[:page])
    end
  end
  
  def show
    begin
      @post = Post.find(params[:id])
      @comments = @post.comments.paginate(page: params[:page])
      @user = @post.user
      if signed_in?
        @comment = current_user.comments.build
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to posts_path
    end
  end
  
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
