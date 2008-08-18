ActionController::Routing::Routes.draw do |map|
  map.page ':action', :controller => 'pages'
  map.root :controller => 'pages'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
