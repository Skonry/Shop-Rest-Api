Rails.application.routes.draw do
  resources :carts do
    resources :cart_products
  end
  resources :products
end
