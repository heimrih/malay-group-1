class ActivitiesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :find_post, only: %i(create destroy update)

  def index
    @activities = Activity.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = @post.activities.create activity_params.merge user_id: current_user.id
    if @activity.save
      flash[:success] = t "activity.create"
      redirect_to post_path id: params[:post_id]
    else
      flash.now[:warning] = t "activity.createfail"
      render :new
    end
  end

  def edit; end

  def update
    if @activity.update activity_params
      flash[:success] = t "activity.update"
      redirect_to post_path
    else
      flash.now[:warning] = t "activity.updatefail"
      render :edit
    end
  end

  def destroy
    @activity = @post.activities.find_by id: params[:id]
    if @activity.destroy
      flash[:success] = t "activity.delete"
    else
      flash[:warning] = t "activity.deletefail"
    end
    redirect_to post_path @post
  end

  private

  def activity_params
    params.require(:activity).permit :field
  end

  def find_post
    @post = Post.find_by id: params[:post_id]
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
    @post = current_user.posts.find_by id: params[:post_id]
    return if @post

    flash[:warning] = t "posts.notfound"
    redirect_to root_path
  end
end
