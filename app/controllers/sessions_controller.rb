class SessionsController < ApplicationController
    
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      flash[:success] = 'Welcome back! Hope you enjoy your stay!'
      redirect_to posts_url
    else
      flash.now[:danger] = "Invalid email/password submission"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

end

