class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attributes activated: true, activated_at: Time.zone.now
      login user
      flash[:success] = t ".acount_success"

    else
      flash[:danger] = t ".acount_danger"
    end
    redirect_to root_url
  end
end
