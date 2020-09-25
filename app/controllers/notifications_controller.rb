class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find_by id: params[:id]
    @notification.update read: true
    redirect_to post_path @notification.post
  end

  def index
    @notifications = current_user.notifications.sort_by_time.page(params[:page]).per(Settings.notification.default_page)
  end
end
