Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  namespace :admin do
    get "/", to: "base#index"
    resources :users
    resources :addresses
    resources :shippings
    resources :orders
  end
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/checkout", to: "checkout#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/my-account", to: "users#my_account"
  get "/update-account/:id", to: "users#edit", as: :update_account
  put "/update-account/:id", to: "users#update"
  patch "/update-account/:id", to: "users#update"
  get "/shopping_cart", to: "cart#shopping_cart"
  get "search(/:search)", to: "search#index", as: :search
  root "products#index"
  resources :products
  # resources :users
  resources :account_activations, only: :edit
end
