class PagesController < ApplicationController
  include ApplicationHelper
  before_action :check_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :update, :destroy, :history, :helped]
  before_action :set_category, only: [:show, :new, :edit, :destroy]

  def show
    if @page.nil?
      redirect = Redirect.find_by(from: params[:page_handle])
      if redirect
        redirect_to page_path(params[:handle], redirect.to)
      else
        raise ActionController::RoutingError.new('Page Not Found')
      end
    end
  end

  def most_recent
    @page = Page.most_recent(1).first
    redirect_to page_path(@page.category.handle, @page.handle)
  end

  def search
    pages = PgSearch.multisearch(params["query"])
    values = pages.map(&:searchable)
    current_page = params[:page] || 1
    @pages = WillPaginate::Collection.create(current_page, 10, values.length) do |pager|
      pager.replace(values)
    end
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
    remove_duplicate_tags
    @page = Page.new(page_params)
    if @page.save
      redirect_to show_category_path(@page.category.handle), notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def update
    remove_duplicate_tags
    if @page.update(page_params)
      update_commit
      redirect_to page_path(@page.category.handle, @page.handle), notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to show_category_path(@category.handle)
  end

  def helped
    if params[:helped] == "true"
      @page.did_help += 1
    else
      @page.did_not_help += 1
    end
    @page.save(validate: false)
    redirect_to page_path(@page.category.handle, @page.handle), notice: 'Thanks for the feedback'
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
    if params[:page_handle]
      @page = Page.find_by(handle: params[:page_handle])
    else
      @page = Page.find(params[:id])
    end
  end

  def set_category
    @category = Category.find_by(handle: params[:handle])
  end

  def page_params
    params.require(:page).permit(:title, :content, :category_id, :commit_message, :tag_list, :sticky)
  end

  def remove_duplicate_tags
    if params[:page][:tag_list]
      tag_array = params[:page][:tag_list].downcase.split(',').map { |tag| tag.strip }
      params[:page][:tag_list] = tag_array.uniq.join(',')
    end
  end

end
