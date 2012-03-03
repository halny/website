Halny::Application.routes.draw do

  resources :races, path: 'zapisy', only: [:index]

  resources :race_variants, path: 'trasa', only: [] do
    resources :race_registrations, path: 'zapisy', only: [:new, :create]
  end

  resources :race_registrations, only: [:edit, :update, :destroy]

  resource :settings, path: 'konto', only: [:edit, :update]

  namespace :admin do
    resources :races do
      resources :race_variants do
        resources :race_registrations
      end
      resources :race_registrations, only: [:index]
    end
    resources :posts do
      member do
        post :post_to_facebook
      end
    end
    resources :users
    resources :pages
    root :to => "dashboard#show"
  end

  devise_for :users, path: 'accounts'

  resources :posts, path: 'wiadomosci'

  get '/:id(.:format)', to: 'pages#show', as: 'static_page'

  root :to => "posts#index"
end
