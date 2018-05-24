class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    format: {with: VALID_EMAIL_REGEX},
    length: {maximum: Settings.user.email.max_length},
    uniqueness: {case_sensitive: false}
  validates :full_name, presence: true,
    length: {maximum: Settings.user.name.max_length}
  enum role: {admin: 0, user: 1}
  has_many :orders
  has_many :addresses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password.min_length}, allow_nil: true
  scope :list_user, ->(current_user_id){where "id != ?", current_user_id}
  USER_PARAMS = %i(full_name username email role active
    password_digest remember_digest).freeze

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def self.digest string
    cost = BCrypt::Engine.cost
    cost = BCrypt::Engine::MIN_COST if ActiveModel::SecurePassword.min_cost
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def forget
    update_attributes remember_digest: nil
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
