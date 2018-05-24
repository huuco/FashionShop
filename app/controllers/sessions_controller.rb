class SessionsController < ApplicationController
  def new
    redirect_to admin_user_path if current_user.present? && current_user.admin?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      login user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    else
      flash.now[:error] = t ".error_login"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t ".logout"
    redirect_to root_path
  end
end
