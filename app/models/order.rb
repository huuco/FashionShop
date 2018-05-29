class Order < ApplicationRecord
  has_many :order_details
  belongs_to :address
  belongs_to :shipping
  belongs_to :payment
  belongs_to :user

  scope :order_by, ->{order "id DESC"}

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :payment, prefix: true, allow_nil: true

  enum status: %i(error completed watting)

  ORDER_PARAMS = %i(transaction_id user_id total status shipping_id
    payment_id address_id)
end
