class InterestedUserWorker
  include Sidekiq::Worker

  def perform(id)
    interested_user = InterestedUser.find(id)
    interested_user.send_registered_interest_email
  end
end