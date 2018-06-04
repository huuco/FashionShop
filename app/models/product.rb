class Product < ApplicationRecord
  has_many :rates
  has_many :order_details
  has_many :comments
  has_many :wishlists
  has_many :images

  belongs_to :brand
  belongs_to :category

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :brand, prefix: true

  PRODUCT_PARAMS = %i(name price promotion_price quantity short_description
   long_description tag ref brand_id category_id active).freeze

  scope :search_product_name, ->search_product do
    where("products.name LIKE ?", "%#{search_product}%").order(name: :asc)
  end
  scope :related_product, ->(category_id){where(category_id: category_id)}

  scope :order_product_name, ->{order name: :asc}
  scope :order_product_created_at,
    ->{order("created_at DESC").limit(Settings.record_per_page)}

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
