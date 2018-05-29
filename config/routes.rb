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
    resources :brands
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
