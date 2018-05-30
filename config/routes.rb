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
  get "/signup", to:"users#new"
  post "/signup", to:"users#create"
  get "/shopping_cart", to: "cart#shopping_cart"
  get "search(/:search)", to: "search#index" , as: :search
  root "products#index"
  resources :products
  resources :users, only: %i(new create)
  resources :account_activations, only: :edit
end
