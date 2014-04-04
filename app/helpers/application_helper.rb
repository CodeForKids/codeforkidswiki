module ApplicationHelper

  def check_admin
    redirect_to root_url if session[:user_id].nil?
  end

end
