class Product < ApplicationRecord
  belongs_to :category

  scope :filter_by_price, ->(from, to) { where("price > ? AND price < ?", from, to) }
end
