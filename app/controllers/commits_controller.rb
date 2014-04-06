class CommitsController < ApplicationController
  before_action :set_page, only: [:index]

  def index
    @commits = Commit.where(:page_id => @page.id).order('updated_at desc')
  end

private

  def set_page
    @page = Page.find_by(handle: params[:page_handle])
  end

end
