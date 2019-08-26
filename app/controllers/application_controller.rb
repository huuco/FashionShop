class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  before_action :session_cart
  before_action :instagram

  def session_cart
    @cart = session[:cart] || {}
    @products_cart = @cart.map {|id, quantity| [Product.find_by(id: id),
      quantity]}
    @count_product_cart = 0
    @cart.each {|id, quantity| @count_product_cart += quantity}
    @total = total_cart @products_cart
  end

  def total_cart products
    @total = 0
    products.each do |product, quantity|
      @total += product.price * quantity
    end
    @total
  end

  def instagram
    InstagramApi.config do |config|
      config.access_token = ENV["INSTAGRAM_TOKEN"]
      config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
      config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
    end
    @instagram_data = InstagramApi.user(ENV["INSTAGRAM_USER_ID"])
      .recent_media.data
  end
end
