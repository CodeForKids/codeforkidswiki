require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = pages(:one)
    @category = categories(:one)
    setup_controller_tests
  end

  test "should get new" do
    get :new, category_id: @category.id
    assert_response :success
  end

  test "should create page" do
    assert_difference ['Page.count','Commit.count'] do
      post :create, { category_id: @category.id, page: {  title: 'Name', commit_message: 'Commit', content: 'Content', category: @category.id, category_id: @category.id } }
    end

    page = assigns(:page)
    assert_equal 'Name', page.title
    assert_equal 'Content', page.content
    assert_equal 1, page.commits.count

    assert_equal 'Initial Commit', page.commits.last.message

    assert_redirected_to category_page_path(@category, page)
  end

  test "should not create page without commit message" do
    assert_no_difference('Page.count') do
      post :create, { category_id: @category.id, page: {  title: 'Name', commit_message: '', content: 'Content', category: @category.id, category_id: @category.id } }
    end
  end

  test "should not create page without title" do
    assert_no_difference('Page.count') do
      post :create, { category_id: @category.id, page: {  title: '', commit_message: 'Message', content: 'Content', category: @category.id, category_id: @category.id } }
    end
  end

  test "should show page" do
    get :show, { id: @page, category_id: @category.id }
    assert_response :success
  end

  test "should get edit" do
    get :edit,  { :category_id => @category.id, :id => @page }
    assert_response :success
  end

  test "should update page" do
    assert_difference 'Commit.count' do
      patch :update, { :category_id => @category.id, :id => @page, page: {  title: 'NEW NAME', commit_message: 'Commit', content: 'New content', category: @category.id, category_id: @category.id  } }
    end

    page = assigns(:page)
    commit = page.commits.last

    assert_equal 'Commit', commit.message
    assert_equal 1, commit.user.id

    assert_equal 'NEW NAME', page.title
    assert_equal 'New content', page.content
    assert_equal 2, page.commits.count

    assert_redirected_to category_page_path(@category, assigns(:page))
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete :destroy, { id: @page, category_id: @category.id }
    end

    assert_redirected_to category_pages_path(@category)
  end
end
