class OrderMailer < ApplicationMailer
  helper :application
  def order_info order, email, subject
    @order = order
    @address = order.address
    mail to: email, subject: t(subject)
  end
end
