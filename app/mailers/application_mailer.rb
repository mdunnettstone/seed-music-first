class ApplicationMailer < ActionMailer::Base
  default from: 'bookings@seedmusic.co.uk'
  layout 'mailer'

  helper_method :current_host
  def current_host
    Rails.application.config.hostname    
  end
end
