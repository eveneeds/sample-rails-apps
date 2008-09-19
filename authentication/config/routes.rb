ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'index'
  map.resources 'sessions'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
end
