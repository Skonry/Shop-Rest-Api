class ProductBlueprint < Blueprinter::Base
  fields :id, :name, :price

  field :category do |product|
    product.category.name
  end
end

