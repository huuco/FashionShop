Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  namespace :admin do
    root to: "users#index"
    resources :addresses
    resources :brands
    resources :categories
    resources :orders
    resources :products
    resources :shippings
    resources :slides
    resources :users
  end
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/checkout", to: "checkout#index"
  get "/signup", to:"users#new"
  get "/shopping_cart", to: "cart#shopping_cart"
  get "search(/:search)", to: "search#index" , as: :search
  root "products#index"
  resources :products
end
