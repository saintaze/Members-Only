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

end
