class Address < ApplicationRecord
  has_many :orders
  belongs_to :user
  validates :alias, presence: true, uniqueness: {case_sensitive: false}
  validates :full_name, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :phone, presence: true
  validates :user_id, presence: true
  ADDRESS_PARAMS = %i(alias full_name post_code city country phone user_id)
  FRONT_ADDRESS_PARAMS = %i(alias full_name post_code city country phone)
end
