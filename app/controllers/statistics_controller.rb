class StatisticsController < ApplicationController
  def user
    render json: User.group_by_day(:created_at).count
  end

  def post
    render json: Post.group_by_day(:created_at).count
  end
end
