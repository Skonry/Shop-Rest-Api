class CartBlueprint < Blueprinter::Base
  field :id
  
  field :total_price do |cart|
    prices = cart.products.map {|product| product.price}
    prices.sum
  end

  association :products, blueprint: ProductBlueprint
end