class PostRepliesController < ApplicationController
  def create
    @post_reply = current_user.post_replies.create(post_reply_params)
    redirect_to post_path(@post_reply.post)
  end

  private

  def post_reply_params
    params.require(:post_reply).permit(:user_id, :post_id, :message)
  end
end
