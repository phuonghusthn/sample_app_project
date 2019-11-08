Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/home", to: "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/help", to: "static_pages#help"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"

    post "/signup", to: "users#create"
    post "/login", to: "sessions#create"

    delete "/logout", to: "sessions#destroy"

    resources :users do
        member do
          get :following, to: "follows#following"
          get :followers, to: "follows#followers"
        end
    end
    resources :account_activations, only: :edit
    resources :password_resets, only: %i(new create edit update)
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(show create destroy)
  end
end
