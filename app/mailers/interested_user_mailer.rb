class InterestedUserMailer < ApplicationMailer
  default from: 'hello@seedmusic.co.uk'

  def user_registered(user)
    @interested_user = user
    @company = user.company
    @recipient = user.email
    mail(to: @recipient,
      subject: "A music practice room is one step closer. Now spread the word!")
  end
end
