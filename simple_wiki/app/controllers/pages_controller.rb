class PagesController < ApplicationController
  def index
    @page = Page.home
    render :action => (@page ? 'show' : 'no_page')
  end
  
  def show
    @page = Page.find(params[:id])
  end
end
