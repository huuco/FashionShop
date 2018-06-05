class Brand < ApplicationRecord
  has_many :products

  scope :order_name, -> {select(:id, :name, :description).order(name: :asc)}
  scope :search_name, -> search_name do
    where("brands.name LIKE ?", "%#{search_name}%")
  end
end
