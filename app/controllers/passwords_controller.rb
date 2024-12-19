class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[edit update]

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user
      user.generate_password_reset_token!
      PasswordsMailer.reset(user).deliver_later
      redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email_address address exists)."
    else
      redirect_to new_password_path, alert: "No user found with that email_address address."
    end
  end

  def edit
    # Aquí puedes verificar si el token es válido
    unless @user.password_reset_token_valid?
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end
  end

  def update
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      redirect_to new_session_path, notice: "Password has been reset."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private

  def set_user_by_token
    @user = User.find_by(password_reset_token: params[:token])
    if @user.nil?
      redirect_to new_password_path, alert: "Invalid password reset token."
    end
  end
end