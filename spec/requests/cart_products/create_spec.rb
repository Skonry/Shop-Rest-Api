require 'rails_helper'

RSpec.describe "Cart Products Create Action", type: :request do
  context "when send post request" do
    let!(:cart) { Cart.create }
    let!(:category) { FactoryBot.create(:category, name: "Category 1") }
    let!(:product) { FactoryBot.create(:product, name: "Product 1", category_id: category.id) }
    
    before { post "/carts/#{cart.id}/cart_products", :params => {:product_id => product.id} } 

    it "returns status code 201" do
      expect(response).to have_http_status(201)
    end

    it "returns cart product" do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["cart_id"]).to eq(cart.id)
      expect(parsed_response["product_id"]).to eq(product.id)
    end
  end

  context "when send invalid ids in post request" do
    before { post "/carts/999/cart_products", :params => {:product_id => 999} }
    
    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end
  end

  context "when send post request without product id" do
    let!(:cart) { Cart.create }

    before { post "/carts/#{cart.id}/cart_products" }

    it "returns status code 400" do
      expect(response).to have_http_status(400)
    end

    it "returns error message" do
      expect(JSON.parse(response.body)["message"]).to eq("Validation failed")
    end
  end
end