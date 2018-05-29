class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  delegate :name, to: :product, prefix: true, allow_nil: true
  delegate :price, to: :product, prefix: true, allow_nil: true
end
