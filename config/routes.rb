Halny::Application.routes.draw do

  resources :races, path: 'zapisy', only: [:index]

  resources :race_variants, path: 'trasa', only: [] do
    resources :race_registrations, path: 'zapisy', only: [:new, :create]
  end

  resources :users

  resources :race_registrations, only: [:edit, :update]

  devise_for :users

  resources :posts, path: 'wiadomosci'

  root :to => "posts#index"
end
