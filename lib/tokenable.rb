module Tokenable
  extend ActiveSupport::Concern

  def generate_password_token
    begin
      token = SecureRandom.urlsafe_base64
    end while User.where(password_reset_token: token).exists?
    self.password_reset_token = token
  end

  def generate_invitation_token
    begin
      token = Digest::MD5.hexdigest([Time.now, rand].join)
    end while Invitation.where(token: token).exists?
    self.token = token
  end
end