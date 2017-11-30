class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_is_admin
    unless current_user.admin == true
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_account
  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end
end
