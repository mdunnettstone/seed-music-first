class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.search(search_params)
    @post = Post.new
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.valid?
      redirect_to posts_path
    else
      # should probably do some proper error validation here
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])

    if @post.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end

    @post.update_attributes(post_params)
    if @post.valid?
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:category, :title, :message, :live, :user_id)
  end

  def search_params
    params.permit(:text, :categories)
  end
end
