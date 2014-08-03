require 'test_helper'

class OmniauthCallbacksControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new({"provider"=>"google_oauth2", "uid"=>"1234", "info"=>{"name"=>"Julian Nadeau", "email"=>"julian2@code-for-kids.com", "first_name"=>"Julian", "last_name"=>"Nadeau", "image"=>"https://lh5.googleusercontent.com/-4lJmLgg2oLo/AAAAAAAAAAI/AAAAAAAAABg/t9NJxEZFEiw/photo.jpg", "urls"=>{"Google"=>"https://plus.google.com/110245799719043269678"}}, "credentials"=>{"token"=>"ya29.1.AADtN_Vo2NdFoNOUFa-ZkQhWaXgQrskzGxV4G6wCO9LbrQHUOzawcwJFm5fM6Ql3", "expires_at"=>1396762379, "expires"=>true}, "extra"=>{"id_token"=>"1234", "raw_info"=>{"id"=>"1234", "email"=>"julian@code-for-kids.com", "verified_email"=>true, "name"=>"Julian Nadeau", "given_name"=>"Julian", "family_name"=>"Nadeau", "link"=>"https://plus.google.com/110245799719043269678", "picture"=>"https://lh5.googleusercontent.com/-4lJmLgg2oLo/AAAAAAAAAAI/AAAAAAAAABg/t9NJxEZFEiw/photo.jpg", "gender"=>"male", "locale"=>"en", "hd"=>"code-for-kids.com"}}} )
  end

  test "should get index" do
    assert_difference 'User.count' do
      get :google_oauth2
    end

    user = assigns(:user)

    assert_equal 'GoogleAuth', user.password
    assert_equal 'Julian', user.first_name
    assert_equal 'Nadeau', user.last_name
    assert_equal 'Julian Nadeau', user.username

    assert_not_nil session[:user_id]
    assert_equal 'julian2@code-for-kids.com', session[:user_email]

    assert_redirected_to root_url
  end

end
