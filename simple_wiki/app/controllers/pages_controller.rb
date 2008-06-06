class PagesController < ApplicationController
  def index
    @page = Page.home
    render :action => (@page ? 'show' : 'no_page')
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  

  def update
    @page = Page.find(params[:id])
    @page.update_attributes!(params[:page])
    redirect_to page_path(@page)
  end
end
