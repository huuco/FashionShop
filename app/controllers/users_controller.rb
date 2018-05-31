class UsersController < ApplicationController
  before_action :find_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".confirm_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def my_account; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".save_success"
    end
    rener :edit
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t ".user_not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
