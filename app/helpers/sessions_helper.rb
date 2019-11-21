module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if id = session[:user_id]
      @current_user = User.find_by(id: id)
    end
  end

  def logout
    session.delete(:user_id)
  end

  def logged_in?
    !!current_user
  end

  def logged_in_user
    unless logged_in?
      puts "HELLLO DARLING"
      flash[:danger] = "Login to read or create secrets!"
      redirect_to login_url
    end
  end



end
