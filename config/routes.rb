Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
   resources :relationships, only: [:create, :destroy] do
      member do
        get 'follower' => 'relationships#follower_index', as: 'follower_index'
        get 'followed' => 'relationships#followed_index', as: 'followed_index'
      end
   end
  end
  resources :books do
   resources :book_comments, only: [:create, :destroy]
   resource :favorites, only: [:create, :destroy]
  end
  
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
end