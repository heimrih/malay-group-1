class PostsController < ApplicationController
  before_action :load_post, except: %i(index new create)

  def index
    @posts = Post.order(:created_at).page(params[:page]).per Settings.posts.page.max
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      flash[:success] = t "posts.create"
      redirect_to @post
    else
      flash.now[:warning] = t "posts.createfail"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update post_params
      flash[:success] = t "posts.update"
      redirect_to @post
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
end
