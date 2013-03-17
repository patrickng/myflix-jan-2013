class PasswordResetController < ApplicationController
  def index
  end

  def create
    user = User.find_by_email_address(params[:email_address])
    if user.present?
      user.generate_and_store_password_token
      UserMailer.delay.password_reset(user.id)
      redirect_to root_path, flash: { notice: "Email sent with instructions to reset your password." }
    else
      redirect_to root_path, flash: { error: "No such email." }
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:token])

    if @user.present?
      if @user.token_expired?
        redirect_to password_reset_path, flash: { error: "Password reset token is invalid or has expired. Request a new password reset email." }
      else
        @token = params[:token]
      end  
    else
      redirect_to password_reset_path, flash: { error: "Password reset token is invalid or has expired. Request a new password reset email." }
    end
  end

  def update
    @user = User.find_by_password_reset_token(params[:token])

    if @user.update_attributes(password: params[:password])
      @user.clear_password_reset_token
      @user.save(validate: false)
      redirect_to login_path, flash: { success: "Password has been reset!" }
    else
      render :edit
    end
  end
end
