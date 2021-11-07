Rails.application.routes.draw do
  resources :carts, only: [:create, :show] do
    resources :cart_products, only: [:create, destroy]
  end
  get "cart/:id/complete", to "carts#complete"

  resources :products, only: [:index]
  get "products/find", to: "products#find"
end
