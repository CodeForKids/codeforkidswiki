class CategoriesController < ApplicationController
  include ApplicationHelper
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @recents = Page.most_recent(8)
  end

  def show
    @per_page = params[:per_page] || 5
    @page_number = params[:page] || 1
    @pages = Page.where(category: @category).paginate(page: @page_number, per_page: @per_page)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to show_category_path(@category.handle), notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to show_category_path(@category.handle), notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to root_url
  end

  private

  def set_category
    @category = Category.find_by(handle: params[:handle]) || Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :fontawesome, :hidden)
  end
end
