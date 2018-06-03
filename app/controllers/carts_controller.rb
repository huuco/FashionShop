class CartsController < ApplicationController
  before_action :load_product, except: :index

  def index; end

  def update
    respond_to do |format|
      cart = session[:cart] ||= {}
      @qty = params[:qty].to_i
      cart[@product.id.to_s] = @qty if cart[@product.id.to_s]
      session_cart
      format.json
    end
  end

  def add
    respond_to do |format|
      cart = session[:cart] ||= {}
      cart[@product.id.to_s] = cart[@product.id.to_s] ? (cart[@product.id.to_s].to_i + 1) : 1
      session_cart
      format.js
    end
  end

  def destroy
    respond_to do |format|
      cart = session[:cart] ||= {}
      cart.delete(@product.id.to_s) if cart[@product.id.to_s]
      session_cart
      format.js
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
  end
end
