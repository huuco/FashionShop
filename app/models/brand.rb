class Brand < ApplicationRecord
  has_many :products
  scope :order_brand, -> {select(:id, :name, :description).order(name: :ASC)}
  scope :search_brand, -> search_name do
    where("brands.name LIKE ?", "%#{search_name}%")
  end
end
