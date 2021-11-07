require 'rails_helper'

RSpec.describe "Carts Products Destroy Action", type: :request do
  context "when send delete request" do
    let(:cart) { FactoryBot.create(:cart) }
    let(:product) { FactoryBot.create(:product, name: "Product 1", category_id: 1) }
    
    before { 
      post "/cart/1/cart_product", :params => {:card_id => 1, :product_id => 1}
      delete "/cart/1/cart_product/1" 
    } 

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end

    it "remove cart product" do
      expect(CartProducts.all.size).to eq(0)
    end
  end
end