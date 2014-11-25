class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_current_user, :except => :ping

  def set_current_user
    User.current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    User.current_user = nil
  end

  def logout
    session[:user_id] = nil
    session[:user_email] = nil
    flash[:notice] = "Successfully logged out."

    redirect_to root_url
  end

  def ping
    render inline: "ACK"
  end

end
