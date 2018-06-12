class Admin::UsersController < Admin::BaseController
  before_action :load_user, except: %i(index create new)
  before_action :admin_user, only: :destroy

  def index
    @users = User.list_user(current_user.id)
                 .search(params[:search])
                 .page(params[:page])
                 .per Settings.limit_page
  end

  def show
    orders = Order.chart_by_total_created_at @user.id
    @chart_data = []
    orders.map{|e| @chart_data.push([e.created_at, e.total])}
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".create_succeed"
      redirect_to admin_users_path
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_succeed"
      redirect_to admin_users_path
    else
      flash[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_succeed"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_users_path
  end

  def activated
    @user.update_attributes activated: params[:activated]
    respond_to do |format|
      format.json
    end
  end

  private

  def user_params
    params.require(:user).permit User::ADMIN_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found_user"
    redirect_to admin_users_path
  end

  def admin_user
    redirect_to admin_users_path unless current_user.admin?
  end
end
