class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :full_name, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validates :username, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validates :email, presence: true,
    format: {with: VALID_EMAIL_REGEX},
    length: {maximum: Settings.user.email.max_length},
    uniqueness: {case_sensitive: false}
   validates :password, length: {minimum: Settings.user.password.min_length},
    allow_nil: true
  enum role: %i(admin user)

  has_many :orders
  has_many :addresses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :product_wishlists, through: :wishlists, source: :product

  scope :search, (lambda do |search|
  select(:id, :full_name, :username, :email, :activated, :role).
    where "full_name LIKE :q OR username LIKE :q OR email LIKE :q",
    q: "%#{search}%"
  end
  )

  has_secure_password
  ADMIN_PARAMS = %i(full_name username email
    password password_confirmation role activated).freeze

  USER_PARAMS = %i(full_name username email
    password password_confirmation).freeze

  scope :list_user, ->(current_user_id){where "id != ?", current_user_id}

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

  def authenticated? attribute, token
    digest = self.send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_info_login_social
    UserMailer.info_password_google(self).deliver_now
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).
      first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.first_name
        user.username = auth.info.last_name
        user.full_name = auth.info.first_name
        user.email = auth.info.email
        user.password = Settings.password_email
        user.image = auth.info.image
        user.activated = Settings.account_actived
        user.save!
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
