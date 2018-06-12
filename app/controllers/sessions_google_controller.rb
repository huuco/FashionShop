class SessionsGoogleController < ApplicationController

  def create
    @user = User.from_omniauth request.env["omniauth.auth"]
    session[:user_id] = @user.id
    @user.send_info_login_social
    flash[:info] = t ".info_email"
    redirect_to root_path
  end

end
