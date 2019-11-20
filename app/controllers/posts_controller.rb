class PostsController < ApplicationController
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

    else
      render 'new'
    end

  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
