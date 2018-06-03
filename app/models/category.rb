class Category < ApplicationRecord
  has_many :products

  PARAMS_LIST = %i(name description active parent_id)
  scope :search, (lambda do |search|
    where "name LIKE :q OR description LIKE :q OR parent_id LIKE :q
      OR active LIKE :q", q: "%#{search}%"
    end)
  scope :order_name, ->{order(name: :asc)}
end
