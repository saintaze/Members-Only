class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]

  include PostsHelper

  def index
    @view = params[:view] || 'paginated'
    if @view == 'paginated'
      post_pagination_nav    
    elsif @view == 'story'
      post_arrow_nav     
    elsif @view == 'all'
      @posts = Post.all
      @posts_count ||= @posts.count
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post Created: Now you are part of the secret order!"
      redirect_to posts_url
    else
      render 'new'
    end

  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
