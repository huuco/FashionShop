class OrdersHistoryController < ApplicationController
  before_action :logged_in?, only: %i(index show)
  before_action :load_order, only: :show

  def index
    @orders = current_user.orders.order_by.page(params[:page])
      .per Settings.record_per_page
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
