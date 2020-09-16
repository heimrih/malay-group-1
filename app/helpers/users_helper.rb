module UsersHelper
  def gravatar_for user
    user.avatar.present? ? user.avatar.url : "default.png"
  end
end
