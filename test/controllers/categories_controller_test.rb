require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    setup_controller_tests
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, { :category => { :name => 'NEW Category' } }
    end

    category = assigns(:category)
    assert_equal 'NEW Category', category.name

    assert_redirected_to show_category_path(category.handle)
  end

  test "should not create category without name" do
    assert_no_difference('Category.count') do
      post :create, { :category => { :name => '' } }
    end
  end

  test "should not create category without unique name" do
    assert_no_difference('Category.count') do
      post :create, { :category => { :name => @category.name } }
    end
  end

  test "should show category" do
    get :show, handle: @category.handle
    assert_response :success
  end

  test "should get edit" do
    get :edit, handle: @category.handle
    assert_response :success
  end

  test "should update category" do
    patch :update, { :id => @category, :category => { :name => 'UPDATE Category' } }

    category = assigns(:category)
    assert_equal 'UPDATE Category', category.name

    assert_redirected_to show_category_path(category.handle)
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, handle: @category.handle
    end

    assert_redirected_to root_url
  end
end
