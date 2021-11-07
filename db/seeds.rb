require 'faker'

20.times do
  Category.create!(
    name: Faker::Commerce.department
  )
end

200.times do
  p = Product.create!(
    category_id: Faker::Number.between(from: 1, to: 20),
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..1000.0, as_string: true)
  )
  puts Faker::Commerce.price
end
