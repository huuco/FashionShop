class Admin::ShippingsController < Admin::BaseController
  before_action :find_shipping, only: %i(edit destroy update)

  def index
    @shippings = Shipping.page(params[:page]).per Settings.limit_page
  end

  def new
    @shipping = Shipping.new
  end

  def create
    @shipping = Shipping.new shipping_params

    if @shipping.save
      flash[:success] = t ".save_success"
      redirect_to admin_shippings_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @shipping.update shipping_params
      flash[:success] = t ".save_success"
      redirect_to admin_shippings_path
    else
      render :update
    end
  end

  def destroy
    if @shipping.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_error"
    end
    redirect_to admin_shippings_path
  end

  private

  def find_shipping
    @shipping = Shipping.find_by id: params[:id]
    return if @shipping
    flash[:danger] = t ".shipping_not_found"
    redirect_to admin_shippings_path
  end

  def shipping_params
    params.require(:shipping).permit :title, :description, :price
  end
end
