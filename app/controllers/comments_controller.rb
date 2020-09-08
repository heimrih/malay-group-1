class CommentsController < ApplicationController
  before_action :find_post, only: %i(create destroy)

  def index; end

  def show; end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.create comment_params
    if @comment.save
      flash[:success] = t "comments.create"
    else
      flash[:warning] = t "comments.createfail"
    end
    redirect_to post_path @post
  end

  def destroy
    @comment = @post.comments.find_by id: params[:id]
    if @comment.destroy
      flash[:success] = t "comments.delete"
    else
      flash[:warning] = t "comments.deletefail"
    end
    redirect_to post_path @post
  end

  private

  def comment_params
    params.require(:comment).permit :username, :body
  end

  def find_post
    @post = Post.find_by id: params[:post_id]
    return if @post

    flash[:warning] = t "posts.notfound"
    redirect_to @post
  end
end
