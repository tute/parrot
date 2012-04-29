Dummy::Application.routes.draw do
  devise_for :users

  resources :posts do
    resources :parrot_comments, controller: 'parrot/comments', path: 'comments'
  end
  root :to => 'posts#index'
end
