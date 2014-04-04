module ApplicationHelper

  def check_admin
    redirect_to root_url if session[:user_id].nil?
  end

  def current_user
    @current_user = User.find(session[:user_id])
  end

end
