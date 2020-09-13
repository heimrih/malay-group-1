module UsersHelper
  def gravatar_for user
    user.avatar ? user.avatar.url : "default.png"
  end
end
