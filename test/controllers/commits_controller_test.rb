require 'test_helper'

class CommitsControllerTest < ActionController::TestCase
  setup do
    @commit = commits(:one)
    @page = pages(:one)
    @category = categories(:one)
    setup_controller_tests
  end

  test 'should get index' do
    get :index, page_handle: @page.handle, handle: @category.handle
    assert_response :success
    assert_not_nil assigns(:commits)
  end

  test 'should get index as json' do
    get :index, page_handle: @page.handle, handle: @category.handle, format: :json
    assert_response :success
    assert JSON.parse(response.body)
  end
end
