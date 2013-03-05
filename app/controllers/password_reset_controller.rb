class PasswordResetController < ApplicationController
  def index
  end

  def create
    user = User.find_by_email_address(params[:email_address])
    if user.present?
      user.send_password_reset_email
      redirect_to root_path, flash: { notice: "Email sent with instructions to reset your password." }
    else
      redirect_to root_path, flash: { error: "No such email." }
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])

    if @user.token_expired?
      redirect_to password_reset_path, flash: { error: "Password reset token is invalid or has expired. Request a new password reset email." }
    end
    end
  end

  def update
    @user = User.find_by_password_reset_token(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to login_path, flash: { success: "Password has been reset!" }
    else
      render :edit
    end
  end
end
