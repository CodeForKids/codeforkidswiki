require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = pages(:one)
    @page2 = pages(:two)
    @category = categories(:one)
    @redirect = redirects(:one)
    setup_controller_tests
  end

  test "should get new" do
    get :new, handle: @category.handle
    assert_response :success
  end

  test 'should redirect to root without login' do
    session[:user_id] = nil
    get :edit, { :handle => @category.handle, :id => @page }
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should create page" do
    assert_difference ['Page.count','Commit.count'] do
      post :create, { handle: @category.handle, page: {  title: 'Name', commit_message: 'Commit', content: 'Content', category: @category.id, category_id: @category.id } }
    end

    page = assigns(:page)
    assert_equal 'Name', page.title
    assert_equal 'Content', page.content
    assert_equal 1, page.commits.count

    assert_equal 'Initial Commit', page.commits.last.message
    assert_redirected_to show_category_path(@category.handle)
  end

  test "should not create page without commit message" do
    assert_no_difference('Page.count') do
      post :create, { category_id: @category.id, page: {  title: 'Name', commit_message: '', content: 'Content', category: @category.id, category_id: @category.id } }
    end
  end

  test "should not create page without title" do
    assert_no_difference('Page.count') do
      post :create, page: {  title: '', commit_message: 'Message', content: 'Content', category: @category.id, category_id: @category.id }
    end
  end

  test "should not create page without unique title" do
    assert_no_difference('Page.count') do
      post :create, page: {  title: @page.title, commit_message: 'Message', content: 'Content', category: @category.id, category_id: @category.id }
    end
  end

  test "should show page" do
    get :show, { page_handle: @page.handle, handle: @category.handle }
    assert_response :success
  end

  test "should redirect show page that 404s" do
    @page.delete
    get :show, { page_handle: @page.handle, handle: @category.handle }
    assert_redirected_to page_path(@category.handle, @page2.handle)
  end

  test "should 404 page" do
    assert_raises ActionController::RoutingError do
      get :show, { page_handle: "doesnt-exit", handle: @category.handle }
    end
  end

  test "should get edit" do
    get :edit,  { :handle => @category.handle, :id => @page }
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
    assert_equal 'new-name', page.handle
    assert_equal 2, page.commits.count

    assert_redirected_to page_path(@category.handle, page.handle)
  end

  test "should fail to update page without title" do
    assert_no_difference 'Commit.count' do
      patch :update, { :category_id => @category.id, :id => @page, page: {  title: '', commit_message: 'Commit', content: 'New content', category: @category.id, category_id: @category.id  } }
    end
    assert_template :edit
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete :destroy, { page_handle: @page.handle, handle: @category.handle }
    end

    assert_redirected_to show_category_path(@category.handle)
  end

  test "should change page help" do
    before = @page.did_help
    post :helped, { id: @page.id, helped: "true" }
    assert_equal before + 1, Page.find(@page.id).did_help
    assert_redirected_to page_path(@category.handle, @page.handle)
  end

  test "should change page did not help" do
    before = @page.did_not_help
    post :helped, { id: @page.id, helped: "false" }
    assert_equal before + 1, Page.find(@page.id).did_not_help
    assert_redirected_to page_path(@category.handle, @page.handle)
  end

  test "should create page with duplicate tags" do
    assert_difference ['Page.count','Commit.count'] do
      post :create, { handle: @category.handle, page: {  tag_list: "programming, Programming, program, Program", title: 'Name', commit_message: 'Commit', content: 'Content', category: @category.id, category_id: @category.id } }
    end

    page = assigns(:page)
    assert_equal ["programming", "program"], page.tag_list
    assert_redirected_to show_category_path(@category.handle)
  end
end
