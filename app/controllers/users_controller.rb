class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new, :create]
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "Usuario creado exitosamente." }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :username, :password, :profile_image, :birth_date)
  end

  def redirect_if_authenticated
    if user_signed_in?
      redirect_to root_path # O redirigir a una ruta de tu elección
    end
  end
end