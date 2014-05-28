class PagesController < ApplicationController
  include ApplicationHelper
  before_action :check_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :update, :destroy, :history]
  before_action :set_category, only: [:new, :edit, :destroy]

  def show
  end

  def category
  end

  def new
    @page = Page.new
    @category = Category.find_by(handle: params[:handle])
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to show_category_path(@page.category.handle), notice: 'Page was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @page.update(page_params)
      update_commit
      redirect_to page_path(@page.category.handle, @page.handle), notice: 'Page was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to show_category_path(@category.handle)
  end

private

  def update_commit
    commit = Commit.new
    commit.page = @page
    commit.user = User.current_user
    commit.message = params[:page][:commit_message]
    commit.save!
  end

  def set_page
    @page = Page.find_by(handle: params[:page_handle]) || Page.find(params[:id])
    check_admin
  end

  def set_category
    @category = Category.find_by(handle: params[:handle])
  end

  def page_params
    params.require(:page).permit(:title,:content,:category_id,:commit_message)
  end

end
