class Admin::WhitelistedEmailsController < ApplicationController
  def create
    WhitelistedEmail.create(whitelisted_email_params)
    redirect_to admin_whitelisted_emails_path
  end

  def index
    @all_emails = WhitelistedEmail.where("(email_or_domain like ?)", "%@%")
    @all_domains = WhitelistedEmail.where.not("(email_or_domain like ?)", "%@%")
    @whitelisted_email = WhitelistedEmail.new
  end

  private

  def whitelisted_email_params
    params.require(:whitelisted_email).permit(:email_or_domain)
  end
end
