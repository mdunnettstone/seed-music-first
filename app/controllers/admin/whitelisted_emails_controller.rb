class Admin::WhitelistedEmailsController < ApplicationController
  def create
    current_account.whitelisted_emails.create(whitelisted_email_params)
    redirect_to admin_whitelisted_emails_path
  end

  def index
    @all_emails = current_account.whitelisted_emails.where("(email_or_domain like ?)", "%@%")
    @all_domains = current_account.whitelisted_emails.where.not("(email_or_domain like ?)", "%@%")
    @whitelisted_email = WhitelistedEmail.new
  end

  private

  def whitelisted_email_params
    params.require(:whitelisted_email).permit(:email_or_domain)
  end
end
