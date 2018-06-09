class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:warning] = t ".logined"
      current_user.admin? ? redirect_to(admin_url) : redirect_to(root_url)
    end
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      if user.admin?
        process_login user
        redirect_to admin_path
      else
        if user.activated?
          process_login user
          redirect_forwarding_url root_url
        else
          flash[:warning] = t ".error_active"
          redirect_to root_url
        end
      end
    else
      flash.now[:danger] = t ".error_login"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    log_out
    flash[:success] = t ".logout"
    redirect_to login_path
  end

  private

  def process_login user
    login user
    forget(user)
    remember(user) if params[:session][:remember_me] == Settings.rememeber_user
  end
end
