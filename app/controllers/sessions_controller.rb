class SessionsController < ApplicationController
    
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = "Welcome #{@user.username}! It\'s great that you wish to read/share scerets."
      redirect_to posts_url
    else
      flash.now[:danger] = "Invalid email/password submission"
      render 'new'
    end
  end

  def destroy
    if logged_in?
      forget current_user
      logout
    end
    redirect_to root_url
  end

end

