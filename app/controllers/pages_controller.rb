class PagesController < ApplicationController
  include ApplicationHelper
  before_action :check_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :update, :destroy, :history]
  before_action :set_category, only: [:new, :edit]

  # GET /pages
  # GET /pages.json
  def index
    @categories = Category.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  def category
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  def history
    @commits = Commit.where(:page => @page)
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to category_page_path(@page.category, @page), notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update

    respond_to do |format|
      if @page.update(page_params)
        update_commit
        format.html { redirect_to category_page_path(@page.category, @page), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private

    def update_commit
      commit = Commit.new
      commit.page = @page
      commit.user = User.current_user
      commit.message = params[:page][:commit_message]
      commit.save!
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_category_page
      @pages = Page.where(:category_id => params[:category])
      @category = Category.find(params[:category])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title,:content,:category_id,:commit_message)
    end
end
