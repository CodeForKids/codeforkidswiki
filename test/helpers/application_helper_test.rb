require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test 'current user' do
    assert_equal current_user, @user
  end

  test 'gravatar' do
    assert_equal 'https://www.gravatar.com/avatar.php?default=&gravatar_id=7d88a4641924c30ad59ba00b200bbd5f&rating=&size=', gravatar('julian@codeforkids.ca')
  end

  test 'pluralize no count' do
    assert_equal 'is', pluralize_no_count(1, 'is', 'are')
    assert_equal 'are', pluralize_no_count(2, 'is', 'are')
  end
end
