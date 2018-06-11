class OrdersHistoryController < ApplicationController
  before_action :logged_in?, only: :index
  before_action :load_order, only: :show

  def index
    @orders = current_user.orders.order_by.page(params[:page]).per 8
  end

  def show
    @address = @order.address
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:warning] = t ".not_found"
    redirect_to root_path
  end
end
