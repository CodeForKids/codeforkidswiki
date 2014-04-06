require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @hash = OmniAuth::AuthHash.new({"provider"=>"google_oauth2", "uid"=>"1234", "info"=>{"name"=>"Julian Nadeau", "email"=>"julian@code-for-kids.com", "first_name"=>"Julian", "last_name"=>"Nadeau", "image"=>"https://lh5.googleusercontent.com/-4lJmLgg2oLo/AAAAAAAAAAI/AAAAAAAAABg/t9NJxEZFEiw/photo.jpg", "urls"=>{"Google"=>"https://plus.google.com/110245799719043269678"}}, "credentials"=>{"token"=>"ya29.1.AADtN_Vo2NdFoNOUFa-ZkQhWaXgQrskzGxV4G6wCO9LbrQHUOzawcwJFm5fM6Ql3", "expires_at"=>1396762379, "expires"=>true}, "extra"=>{"id_token"=>"1234", "raw_info"=>{"id"=>"1234", "email"=>"julian@code-for-kids.com", "verified_email"=>true, "name"=>"Julian Nadeau", "given_name"=>"Julian", "family_name"=>"Nadeau", "link"=>"https://plus.google.com/110245799719043269678", "picture"=>"https://lh5.googleusercontent.com/-4lJmLgg2oLo/AAAAAAAAAAI/AAAAAAAAABg/t9NJxEZFEiw/photo.jpg", "gender"=>"male", "locale"=>"en", "hd"=>"code-for-kids.com"}}} )
    User.current_user = @user
  end

  test "current user" do
    assert_equal @user, User.current_user
  end

  test 'From OmniAuth' do
    assert_equal @user2, User.from_omniauth(@hash)
  end

end
