class StaticPagesController < ApplicationController
  def home

  end

  def unis

  end

  def select_account
    if current_user.present?
      redirect_to home_url(host: "#{current_account.subdomain}.#{current_host}")
    else
      @accounts = Account.all
    end
  end

  def download_uni_doc
    send_file(
      "#{Rails.root}/assets/docs/Seed_Music_University_Scheme",
      filename: "Seed Music University Scheme.pdf",
      type: "application/pdf"
    )
  end
end