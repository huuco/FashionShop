class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :check_admin

  private

  def check_admin
    return if logged_in? && current_user.admin?
    flash[:warning] = t ".warning"
    redirect_to root_path
  end
end
