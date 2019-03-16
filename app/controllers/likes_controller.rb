class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    unless @post.liking?(current_user.id)
      @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.liking?(current_user.id)
      @like = Like.find_by(user_id: current_user.id)
      @like.destroy
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end