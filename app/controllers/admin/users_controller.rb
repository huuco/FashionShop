class Admin::UsersController < Admin::BaseController
  before_action :find_user, except: %i(index create new)
  before_action :admin_user, only: :destroy

  def index
    @users = User.list_user(current_user.id).page(params[:page])
      .per Settings.users.limit_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t "flash.create_user_succeed"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.update_user_succeed"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.delete_user_succeed"
    else
      flash[:danger] = t "flash.delete_user_failed"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.not_found_user"
    redirect_to admin_users_path
  end

  def admin_user
    redirect_to admin_users_path unless current_user.admin?
  end
end
