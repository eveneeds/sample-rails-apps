class RevisionsController < ApplicationController
  def show
    @page = Page.find(params[:page_id])
    @revision = @page.revisions.find_by_number(params[:id])
  end
end
