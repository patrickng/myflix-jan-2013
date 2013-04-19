class User < ActiveRecord::Base
  include Tokenable

  has_secure_password

  validates :full_name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :reviews, dependent: :destroy
  has_many :queue_items, order: :position, dependent: :destroy
  has_many :followed_users, through: :following_relationships, source: :followed
  has_many :following_relationships, foreign_key: "follower_id", dependent: :destroy

  has_many :sent_invitations, class_name: "Invitation", foreign_key: "sender_id", dependent: :destroy
  belongs_to :invitation

  has_many :payments

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

  def generate_and_store_password_token
    generate_password_token
    self.password_reset_sent_at = Time.zone.now
    self.save!(validate: false)
  end

  def token_expired?
    self.password_reset_sent_at < 15.minutes.ago
  end

  def clear_password_reset_token
    self.password_reset_token = nil
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  # Uncomment for invitation limit
  # before_create :set_invitation_limit
  #
  # private
  # def set_invitation_limit
  #   self.invitation_limit = 5
  # end
end