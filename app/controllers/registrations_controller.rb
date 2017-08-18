class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:firstname, :surname, :description, :email, :password, :password_confirmation, :user_instruments)
  end

  def account_update_params
    params.require(:user).permit(:firstname, :surname, :description, :email, :password, :password_confirmation, :current_password, :user_instruments)
  end
end
