class InterestedUsersController < ApplicationController
  def new
    @interested_user = InterestedUser.new
  end

  def create
    @interested_user = InterestedUser.create(iu_params)
    if @interested_user.valid?
      flash[:notice] = "Thanks for expressing an interest"
      redirect_to leaderboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @interested_users = InterestedUser.all
  end

  private

  def iu_params
    params.require(:interested_user).permit(:email, :postcode, :company)
  end
end
