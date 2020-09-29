class PostsController < ApplicationController
  before_action :load_post, except: %i(index new create)
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(edit update)

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per Settings.posts.page.max
  end

  def show
    Post.update_counters [@post.id], views: Settings.posts.view.inc

    # get all activities and user has activity of this post.
    @activities = @post.activities.includes(:user).page(params[:page]).per Settings.activities.per_page_10
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t "posts.create"
      redirect_to posts_path
    else
      flash.now[:warning] = t "posts.createfail"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update post_params
      flash[:success] = t "posts.update"
      redirect_to posts_path
    else
      flash.now[:warning] = t "posts.updatefail"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t "posts.delete"
    else
      flash[:warning] = t "posts.deletefail"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit :title, :body
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:warning] = t "posts.notfound"
    redirect_to root_path
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
