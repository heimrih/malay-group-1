class CommentsController < ApplicationController
  before_action :find_post, only: %i(create destroy)
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(edit update)

  def index; end

  def show; end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.create comment_params.merge(user_id: current_user.id)
    if @comment.save
      create_notification @post, @comment
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

  def create_notification(post, comment)
    return if post.user.id == current_user.id

    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: comment.id,
                        notice_type: "comment")
  end

  def comment_params
    params.require(:comment).permit :username, :body
  end

  def find_post
    @post = Post.find_by id: params[:post_id]
    return if @post

    flash[:warning] = t "posts.notfound"
    redirect_to @post
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.login_remind"
    redirect_to login_path
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    return if @post

    flash[:warning] = t "posts.notfound"
    redirect_to root_path
  end
end
