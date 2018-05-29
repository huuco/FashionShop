class Admin::OrdersController < Admin::BaseController
  before_action :show, only: %i(update)

  def index
    @orders = Order.order_by.page(params[:page]).per Settings.order.limit_page
  end

  def show
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t ".order_not_found"
    redirect_to admin_orders_path
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t ".updated_status_success"
    else
      flash[:danger] = t ".updated_status_error"
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end
end
