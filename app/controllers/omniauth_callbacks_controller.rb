class OmniauthCallbacksController < Devise::OmniauthCallbacksController
include ApplicationHelper

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.password = "GoogleAuth" #We set this to get around a stupid requirement for a password, despite using Google Auth Only

    set_user_info
    set_session_info
    redirect_to root_url
  end

  private

  def set_user_info
    @user.password = "GoogleAuth"
    @user.first_name = request.env["omniauth.auth"].info.first_name
    @user.last_name = request.env["omniauth.auth"].info.last_name
    @user.save!
  end

  def set_session_info
    session[:user_id] = @user.id
    session[:user_email] = @user.email
    flash[:notify] = "Signed in Through Google!"
    User.current_user = @user
  end

end
