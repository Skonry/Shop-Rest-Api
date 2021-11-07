require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  context "when validate" do
    it "cart_id is required" do
      cart_product = CartProduct.create(product_id: 1, cart_id: nil)
      cart_product.valid?
      expect(cart_product.errors[:cart_id].size).to eq(1)
    end

    it "product_id is required" do
      cart_product = CartProduct.create(product_id: nil, cart_id: 1)
      cart_product.valid?
      expect(cart_product.errors[:product_id].size).to eq(1)
    end
  end
end