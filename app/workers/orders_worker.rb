class OrdersWorker
  include Sidekiq::Worker
  def perform(order_id)
    order = Order.find_by id: order_id
    OrderMailer.order_info(order, order.user_email , ".order_info").deliver_now
  end
end
