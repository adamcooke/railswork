class ApplicationController < ActionController::Base
  include AtechUtils, AccessControl
  helper_method :admin?, :logged_in?
  before_filter :get_current_user
  
  def admin?
    @current_user && @current_user.allowed?(1)
  end
end
