class SessionsController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]
  
  def new
    render
  end
  
  def create
    self.current_user = User.authenticate(params[:username], params[:password])
    
    if logged_in?
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    self.current_user = nil
    redirect_to login_path
  end
end
