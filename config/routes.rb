Rails.application.routes.draw do
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/checkout", to: "checkout#index"
  get "/show", to: "products#show"
  get "/product_details", to: "products#product_details"
  get "/signup", to:"users#new"
  get "/shopping_cart", to: "cart#shopping_cart"
  get "/login", to:"sessions#login"
  root "products#index"
end
