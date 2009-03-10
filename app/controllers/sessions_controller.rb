class SessionsController < ApplicationController
  
  def new
    if request.post?
      if user = User.authenticate(params[:username], params[:password])
        session[:user_id] = user.id
        redirect_to home_path
      else
        flash[:error] = "Access Denied"
        render_generic_login
      end
    else
      render_generic_login
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end
  
end
