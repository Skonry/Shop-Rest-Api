require 'rails_helper'

RSpec.describe "Carts Products Destroy Action", type: :request do
  context "when send delete request" do
    let!(:cart) { Cart.create }
    let!(:category) { FactoryBot.create(:category, name: "Category 1") }
    let!(:product) { FactoryBot.create(:product, name: "Product 1", category_id: category.id) }
    
    before { 
      post "/carts/#{cart.id}/cart_products", :params => {:product_id => product.id}
      delete "/carts/#{cart.id}/cart_products/1" 
    } 

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end

    it "remove cart product" do
      expect(CartProduct.all.size).to eq(0)
    end
  end
end