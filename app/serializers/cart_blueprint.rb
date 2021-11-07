class CartBlueprint < Blueprinter::Base
  field :id
  
  field :total_price do |cart|
    cart.products.map({|product| product.price}).sum
  end

  association :products, blueprint: ProductBlueprint
end