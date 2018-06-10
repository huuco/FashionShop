class AdminOrdersWorker
  include Sidekiq::Worker
  def perform(order_id)
    order = Order.find_by id: order_id
    OrderMailer.order_info(order, ENV["ADMIN_EMAIL"], ".new_order").deliver_now
  end
end
