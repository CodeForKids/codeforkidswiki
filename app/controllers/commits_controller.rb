class CommitsController < ApplicationController
  before_action :set_commit, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:index]

  # GET /commits
  # GET /commits.json
  def index
    @commits = Commit.where(:page_id => params[:page_id]).order('updated_at desc')
  end

  # GET /commits/1
  # GET /commits/1.json
  def show
  end

  # GET /commits/new
  def new
    @commit = Commit.new
  end

  # GET /commits/1/edit
  def edit
  end

  # POST /commits
  # POST /commits.json
  def create
    @commit = Commit.new(commit_params)

    respond_to do |format|
      if @commit.save
        format.html { redirect_to @commit, notice: 'Commit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @commit }
      else
        format.html { render action: 'new' }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commits/1
  # PATCH/PUT /commits/1.json
  def update
    respond_to do |format|
      if @commit.update(commit_params)
        format.html { redirect_to @commit, notice: 'Commit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commits/1
  # DELETE /commits/1.json
  def destroy
    @commit.destroy
    respond_to do |format|
      format.html { redirect_to commits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commit
      @commit = Commit.find(params[:id])
    end

    def set_page
      @page = Page.find(params[:page_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commit_params
      params[:commit]
    end
end
