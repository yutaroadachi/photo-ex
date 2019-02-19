class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comments = @post.comments.paginate(page: params[:page])
    @user = @post.user
    if @comment.save
      flash[:success] = "コメントが完了しました！"
      redirect_to @post
    else
      render "posts/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to  request.referrer || @post
  end
  
  private
    def comment_params
      params.require(:comment).permit(:post_id, :content)
    end
end