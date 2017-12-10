class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_is_admin
    unless current_user.admin == true
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_account
  def current_account
    tld_length = Rails.env.production? ? 2 : 1
    return unless request.subdomain(tld_length).present?
    return if request.subdomain(tld_length) == "www"
    @current_account ||= Account.find_by(subdomain: request.subdomain(tld_length))
  end

  def check_account_matches_user
    unless current_user.account == current_account
      redirect_to select_account_url(subdomain: nil)
    end
  end
end
