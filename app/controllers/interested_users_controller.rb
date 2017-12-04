class InterestedUsersController < ApplicationController
  def new
    # @dummy_data = Chartkick.BarChart("chart-1", [["Work", 32], ["Play", 1492]])
    @interested_user = InterestedUser.new
  end

  def create
    @interested_user = InterestedUser.create(iu_params)
    if @interested_user.valid?
      flash[:notice] = "Congratulations, you have added one point to #{@interested_user.company}"
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
