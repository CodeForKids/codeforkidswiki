require 'test_helper'

class RedirectsControllerTest < ActionController::TestCase
  setup do
    @redirect = redirects(:one)
    @page = pages(:one)
    setup_controller_tests
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:redirects)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Redirect.count') do
      post :create, redirect: { from: 'one', to: 'two', page_id: @page.id }
    end

    redirect = assigns(:redirect)
    assert_equal 'one', redirect.from
    assert_equal 'two', redirect.to

    assert_redirected_to redirects_path
  end

  test 'should not create category without to' do
    assert_no_difference('Redirect.count') do
      post :create, redirect: { from: 'one' }
    end
  end

  test 'should get edit' do
    get :edit, id: @redirect
    assert_response :success
  end

  test 'should update category' do
    patch :update, id: @redirect, redirect: { to: 'new_path' }

    redirect = assigns(:redirect)
    assert_equal 'new_path', redirect.to

    assert_redirected_to redirects_path
  end

  test 'should destroy category' do
    assert_difference('Redirect.count', -1) do
      delete :destroy, id: @redirect
    end

    assert_redirected_to redirects_path
  end
end
