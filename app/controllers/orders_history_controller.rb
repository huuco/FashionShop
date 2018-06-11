class OrdersHistoryController < ApplicationController
  before_action :logged_in?, only: :index

  def index
    @orders = current_user.orders
  end
end
