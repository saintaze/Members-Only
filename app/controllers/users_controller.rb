class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the club! You are now part of the select few.  •͡˘㇁•͡˘"
      redirect_to posts_url

      #on successful creation he should be logged in 
      # and take to post creation form
    else 
      render 'new'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
