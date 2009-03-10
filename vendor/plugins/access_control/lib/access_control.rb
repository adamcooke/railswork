module AccessControl
	
	def logged_in?
    !!@current_user
  end
  
  protected
  
  def get_current_user
    @current_user = User.find_by_id_and_enabled(session[:user_id], true) unless session[:user_id].blank?
  end
  
  def require_login
    render_error(403) unless logged_in?
  end
  
  def require_admin
    render_error(403) unless @current_user && @current_user.allowed?(1)
  end
  
  def require_anon
    redirect_to home_path if logged_in?
  end
	
end