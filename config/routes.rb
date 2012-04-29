Parrot::Engine.routes.draw do
  resources :comments
  root :to => 'comments#index'
end
