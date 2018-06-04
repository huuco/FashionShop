Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  namespace :admin do
    get "/", to: "base#index"
    resources :users, except: :show
    resources :addresses
    resources :shippings
    resources :orders
    resources :brands, except: :show
    resources :categories, except: :show
    resources :products, except: :show
    resources :slides, except: :show
    resources :payments, except: :show
  end

  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to:"users#new"
  post "/signup", to:"users#create"
  get "/my-account", to: "users#show"
  get "/update-account/:id", to: "users#edit", as: :update_account
  put "/update-account/:id", to: "users#update"
  patch "/update-account/:id", to: "users#update"
  get "/shopping_cart", to: "cart#shopping_cart"
  get "search(/:search)", to: "search#index", as: :search
  get "search_brand(/:search)", to: "search1#index", as: :search_brand

  root "products#index"
  resources :products
  resources :account_activations, only: :edit
  post "/add_to_cart/:id", to: "carts#add", as: :add_to_cart
  post "/remove_product_from_cart/:id", to: "carts#destroy",
    as: :remove_product_from_cart
  post "/update_cart/:id", to: "carts#update", as: :update_cart
  post "/remove_cart/:id", to: "carts#destroy", as: :remove_cart
  resources :carts, only: :index
  resources :addresses
  resources :checkouts, only: %i(index create) do
    collection do
      get "/ajax_address", to: "checkouts#ajax_address"
    end
  end
  resources :categories, only: :show
end
