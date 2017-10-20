class Admin::FacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.create(facility_params)
    redirect_to root_path
  end

  private

  def facility_params
    params.require(:facility).permit(:instrument, :brand, :model)
  end
end
