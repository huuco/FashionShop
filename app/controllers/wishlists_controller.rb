class WishlistsController < ApplicationController
  before_action :logged_in?, only: %i(index create destroy)
  before_action :load_product, only: :create

  def index
    @products = current_user.product_wishlists
  end

  def create
    @wishlist = current_user.wishlists.build product: @product
    @wishlist.save
  end

  def destroy
    @wishlist = current_user.wishlists.find_by product_id: params[:id]
    if @wishlist.present?
      @wishlist.destroy
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:warning] = t "search.product_not_found"
    redirect_to root_url
  end
end
