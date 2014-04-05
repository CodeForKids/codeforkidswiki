class CommitsController < ApplicationController
  before_action :set_commit, only: [:show]
  before_action :set_page, only: [:index]

  def index
    @commits = Commit.where(:page_id => params[:page_id]).order('updated_at desc')
  end

  def show
  end

private

  def set_commit
    @commit = Commit.find(params[:id])
  end

  def set_page
    @page = Page.find(params[:page_id])
  end

end
