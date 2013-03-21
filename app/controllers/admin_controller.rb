class AdminController < AuthenticatedController
  before_filter :require_admin

  def require_admin
    redirect_to home_path, flash: { error: "You do not have access to that area." } unless current_user.admin?
  end
end