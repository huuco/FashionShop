module SessionsHelper
  def login user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    cookies.delete :remember_token
    @current_user = nil
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def session_cart
    @cart = session[:cart] || {}
    @products_cart = @cart.map {|id, quantity| [Product.find_by(id: id), quantity]}
    @count_product_cart = 0
    @cart.each {|id, quantity| @count_product_cart+=quantity}
    @total = total_cart @products_cart
  end
end
