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

  validates :shipping, presence: true
  validates :payment, presence: true

  ORDER_PARAMS = %i(transaction_id user_id total status shipping_id
    payment_id address_id).freeze

  after_commit :send_order_info, on: :create

  def send_order_info
    OrdersWorker.perform_in(Settings.delay_time.seconds, id)
    AdminOrdersWorker.perform_in(Settings.delay_time.seconds, id)
  end
end
