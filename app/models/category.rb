class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true
  PARAMS_LIST = %i(name description parent_id active)
  scope :order_name, ->{order(name: :desc)}
  scope :search_admin_c, (lambda do |search|
    where "name LIKE :q OR parent_id LIKE :q", q: "%#{search}%"
  end)
end
