class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  before_filter :login_required
    
  def login_required
    redirect_to login_path unless logged_in?
  end
  
  def logged_in?
    current_user != nil
  end
  helper_method :logged_in
  
  def current_user
    @current_user ||= session[:user] ? User.find(session[:user]) : nil
  end
  helper_method :current_user
  
  def current_user=(user)
    if user.is_a?(User)
      session[:user] = user.id
      @current_user = user
    else
      session[:user] = @current_user = nil
    end
  end
end
