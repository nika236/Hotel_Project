module ApplicationHelper
  def require_admin
    unless  current_user.admin?
      redirect_to hotels_path, alert: "You must be an admin to access this page."
    end
  end

  def not_require_admin
    if current_user.admin?
      redirect_to hotels_path, alert: "admin can't access this page."
    end
  end

end
