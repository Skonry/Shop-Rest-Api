class CartBlueprint < Blueprinter::Base
  field :id
  
  association :products, blueprint: ProductBlueprint
end