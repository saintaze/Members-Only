class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new, :destroy]
  before_action :non_admin_user, only: [:new]
  before_action :admin_user, only: [:destroy]

  include PostsHelper

  def index
    @view = params[:view] || 'paginated'
    if @view == 'paginated'
      post_pagination_nav    
    elsif @view == 'story'
      post_arrow_nav     
    elsif @view == 'all'
      @posts = Post.search(params[:search])
      @posts_count ||= @posts.count
      if params[:search] && @posts_count == Post.count
        @search_posts_not_found = true
      elsif params[:search] && @posts_count > 0
        @search_posts_found = true
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created! It feels great to share secrets."
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def destroy
    if params[:id] == 'all'
      Post.delete_all
      flash[:success] = "Success! All Secrets deleted!"
      return redirect_to root_url
    end
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      flash[:success] = "Success! Secret #{params[:id]} deleted!"
      Post.count == 0 ? redirect_to(root_url) : redirect_to(posts_url)
    end
    
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def admin_user
      unless current_user.admin? 
        flash[:danger] = "Danger! Only admin can destroy secrets."
        redirect_to root_url
      end
    end

    def non_admin_user
      if current_user.admin? 
        flash[:danger] = "Not Allowed! Non-Admins can't create secrets."
        redirect_to root_url
      end
    end

end
