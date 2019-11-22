class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      remember @user
      flash[:success] = "Welcome to the club #{@user.username}! You are now part of the select few.  •͡˘㇁•͡˘"
      redirect_to posts_url
    else 
      render 'new'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    

end
