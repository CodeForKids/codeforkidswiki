class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
