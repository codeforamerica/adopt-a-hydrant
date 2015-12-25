module UsersHelper
  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end
end
