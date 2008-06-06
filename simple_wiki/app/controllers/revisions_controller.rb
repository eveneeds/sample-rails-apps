class RevisionsController < ApplicationController
  def show
    @page = Page.find(params[:page_id])
    @revision = @page.revisions.find(params[:id])
  end
end
