class StaticPagesController < ApplicationController
  def home
    if current_user.present?  
      redirect_to home_url(subdomain: current_user.account.subdomain)
    end
  end

  def unis

  end

  def download_uni_doc
    send_file(
      "#{Rails.root}/assets/docs/Seed_Music_University_Scheme",
      filename: "Seed Music University Scheme.pdf",
      type: "application/pdf"
    )
  end
end