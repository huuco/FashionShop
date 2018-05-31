class Admin::UsersController < Admin::BaseController
  def index
    @users = User.page(params[:page]).per(Setttings.limit_page)
  end
end
