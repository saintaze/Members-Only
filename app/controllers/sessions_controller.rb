class SessionsController < ApplicationController
    
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      flash[:success] = 'Welcome! It\'s great that you wish to read/share scerets.'
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

