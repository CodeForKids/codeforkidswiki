class RedirectsController < ApplicationController
  include ApplicationHelper
  before_action :check_admin

  def index
    @redirects = Redirect.all.includes(:page)
  end

  def new
    @redirect = Redirect.new
  end

  def edit
    @redirect = Redirect.find(params[:id])
  end

  def create
    @redirect = Redirect.new(redirect_params)
    if @redirect.save
      redirect_to redirects_path, notice: 'Redirect was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @redirect = Redirect.find(params[:id])
    if @redirect.update(redirect_params)
      redirect_to redirects_path, notice: 'Redirect was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @redirect = Redirect.find(params[:id])
    @redirect.destroy
    redirect_to redirects_path
  end

  private

  def redirect_params
    params.require(:redirect).permit(:from, :to, :page_id)
  end

end
