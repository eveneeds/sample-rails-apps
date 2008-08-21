ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'posts'
  map.resources :posts

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
