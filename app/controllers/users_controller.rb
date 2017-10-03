class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.search(search_params)

    respond_to do |format|
      format.html
      format.xml { render :xml => @users.to_xml }
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  private
  def search_params
    params.permit(:name, :genre_id => [], :instrument_id => [])
  end
end
