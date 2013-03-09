class Invitation < ActiveRecord::Base
  include Tokenable
  validates_presence_of :recipient_email_address
  validates_presence_of :recipient_full_name
  validates_presence_of :recipient_message
  validates_uniqueness_of :recipient_email_address
  validate :recipient_registered

  belongs_to :sender, class_name: 'User'
  has_one :recipient, class_name: 'User'

  before_create :generate_invitation_token

  private

  def recipient_registered
    errors.add :recipient_email_address, 'email already registered' if User.find_by_email_address(recipient_email_address)
  end

  # def has_invites?
  #   unless sender.invitation_limit > 0
  #     errors.add_to_base 'You no invites to send.'
  #   end
  # end
  #
  # def decrease_invite_count
  #   sender.decrement! :invitation_limit
  # end
end
