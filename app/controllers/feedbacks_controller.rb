class FeedbacksController < ApplicationController
  after_action :save_previous_url, only: [:new]

  def new
    @feedback = Feedback.new
  end

  def create
    if current_user.present?
      @feedback = current_user.feedbacks.create(feedback_params)
    else
      @feedback = Feedback.create(feedback_params)
    end
    if @feedback.valid?
      flash[:success] = 'We appreciate your feedback!'
      redirect_to session[:previous_url] || root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:title, :message, :user_id)
  end

  def save_previous_url
    session[:previous_url] = URI(request.referer || '').path
  end
end
