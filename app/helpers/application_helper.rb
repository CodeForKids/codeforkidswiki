module ApplicationHelper

  def check_admin
    redirect_to root_url if session[:user_id].nil?
  end

  def current_user
    @current_user = User.find(session[:user_id])
  end

  def gravatar(email,gravatar_options={})
    grav_url = 'https://www.gravatar.com/avatar.php?'
    grav_url << { :gravatar_id => Digest::MD5.new.update(email), :rating => gravatar_options[:rating], :size => gravatar_options[:size], :default => gravatar_options[:default] }.to_query
    grav_url
  end

  def pluralize_no_count(count, singular, plural = nil)
    ((count == 1 || count == '1') ? singular : (plural || singular.pluralize))
  end

end
