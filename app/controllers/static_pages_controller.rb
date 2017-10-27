class StaticPagesController < ApplicationController
  def home
    if current_user.present?
      redirect_to home_path
    end
  end

  def unis

  end
end
