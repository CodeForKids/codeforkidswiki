require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "test ping" do
    get :ping
    assert 'ACK', response.body
  end

end
