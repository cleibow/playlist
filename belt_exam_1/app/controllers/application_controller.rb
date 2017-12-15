class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :require_login, only: [:index]
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def index
    render 'index'
  end

  private 
  def require_login
    return redirect_to new_session_path unless session.has_key? "user_id"
    # when "logged out", session is reset
  end
  # requires login on any method unless the user is already logged in
end
