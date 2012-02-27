Halny::Application.routes.draw do

  resources :races, path: 'rajdy', only: [:index, :show] do
    resources :race_variants, path: 'trasa', only: [] do
      resources :race_registrations, path: 'zapisy', only: [:new, :create]
    end
  end

  devise_for :users

  resources :posts, path: 'wiadomosci'

  root :to => "posts#index"
end
