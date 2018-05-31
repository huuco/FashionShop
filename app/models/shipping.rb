class Shipping < ApplicationRecord
  has_many :orders
  validates :title, presence: true,
    length: {maximum: Settings.title.maximum}
  validates :price, presence: true,
    numericality: {greater_than: Settings.price.numericality}
end
