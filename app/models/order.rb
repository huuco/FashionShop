class Order < ApplicationRecord
  has_many :order_details
  belongs_to :address
  belongs_to :shipping
  belongs_to :payment
  belongs_to :user

  scope :order_by, ->{order "id DESC"}
  scope :chart_by_total_created_at,
    ->(user_id){eager_load(:user).where user_id: user_id}

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :payment, prefix: true, allow_nil: true

  enum status: %i(error completed watting)

  validates :shipping, presence: true
  validates :payment, presence: true

  ORDER_PARAMS = %i(transaction_id user_id total status shipping_id
    payment_id address_id).freeze

  class << self
    def total_by_day from_day, to_day
      sql = "SELECT SUM(orders.total) as total,
        date(orders.created_at) as created_at FROM orders WHERE created_at
        BETWEEN '#{from_day}' AND '#{to_day}'
        GROUP BY date(created_at)"
      ActiveRecord::Base.connection.execute(sql).map do |total_day|
        [total_day[1],total_day[0]]
      end
    end
  end
end
