require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "test ping" do
    get :ping
    assert 'ACK', response.body
  end

  test 'logout' do
    get :logout
    assert_redirected_to root_url
    assert_nil session[:user_id]
    assert_nil session[:user_email]
  end

end
