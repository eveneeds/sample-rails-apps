class PostsController < ApplicationController
  def index
    @posts = Post.find_for_index.paginate :page => params[:page], :per_page => 4
    session[:last_page] = @posts.current_page

    respond_to do |format|
      format.html { }# index.html.erb
      format.js { render :template => 'posts/index.html.erb' }
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
end
