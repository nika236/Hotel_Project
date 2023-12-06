module ApplicationHelper
  def require_admin
    unless current_user && current_user.admin?
      redirect_to hotels_path, alert: "You must be an admin to access this page."
    end
  end

end
