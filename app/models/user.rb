class User < ActiveRecord::Base
  has_secure_password

  validates :full_name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :reviews, dependent: :destroy
  has_many :queue_items, order: :position, dependent: :destroy
  has_many :followed_users, through: :following_relationships, source: :followed
  has_many :following_relationships, foreign_key: "follower_id", dependent: :destroy

  before_create { generate_token(:password_reset_token) }

  def has_in_queue?(video)
    queue_items.map(&:video).include?(video)
  end

  def following?(other_user)
    !!following_relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by_followed_id(other_user.id).destroy
  end

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while User.where(password_reset_token: token).exists?
    self.password_reset_token = token
  end

  def send_password_reset_email
    generate_token
    self.password_reset_sent_at = Time.zone.now
    self.save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def token_expired?
    self.password_reset_sent_at < 15.minutes.ago
  end
end