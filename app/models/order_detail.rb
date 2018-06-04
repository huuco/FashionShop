class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  scope :best_selling, ->{select("product_id, SUM(quantity) as total_quantity").group("product_id").order("total_quantity DESC").limit Settings.limit_best_seller}

  delegate :name, to: :product, prefix: true, allow_nil: true
  delegate :price, to: :product, prefix: true, allow_nil: true
end
