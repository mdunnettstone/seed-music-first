class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_is_admin
    unless current_user.admin == true
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_account
  def current_account
    return unless request.subdomain(1).present?
    return if request.subdomain(1) == "www"
    @current_account ||= Account.find_by(subdomain: request.subdomain(1))
  end

  def check_account_matches_user
    unless current_user.account == current_account
      redirect_to select_account_url(subdomain: nil)
    end
  end
end
