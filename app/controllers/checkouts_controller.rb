class CheckoutsController < ApplicationController
  def index
    if session[:cart].empty?
      flash[:wraning] = t ".empty_cart"
      redirect_to root_path
    else
      if logged_in?
        @order = Order.new
        get_info_order
        return if @addresses.present?
        flash[:wraning] = t ".need_address"
        store_location
        redirect_to addresses_path
      else
        store_location
        flash[:warning] = t ".need_login"
        redirect_to login_path
      end
    end
  end

  def create
    @order = current_user.orders.build list_params

    if @order.save
      transaction_id = SecureRandom.hex
      while Order.find_by transaction_id: transaction_id
        transaction_id = SecureRandom.hex
      end
      shipping = Shipping.find_by id: list_params[:shipping_id]
      unless shipping
        flash[:danger] = t ".error_shipping"
        redirect_to root_path
      end
      total = @total + shipping.price
      @order.update_attributes transaction_id: transaction_id, total: total,
        status: Order.statuses["watting"]
      @products_cart.each do |product, qty|
        OrderDetail.create product_id: product.id,
          order_id: @order.id,
          quantity: qty,
          total_price: product.promotion_price * qty
      end
      session.delete :cart
      flash[:success] = t ".success"
      redirect_to root_path
    else
      get_info_order
      render :index
    end
  end

  def ajax_address
    @address_first = Address.find_by id: params[:id_address]
    respond_to do |format|
      format.json
    end
  end

  def list_params
    params.require(:order).permit :address_id, :shipping_id, :payment_id
  end

  private

  def get_info_order
    @addresses = current_user.addresses
    @address_first = current_user.addresses.take
    @payments = Payment.all
    @shippings = Shipping.all
  end
end
