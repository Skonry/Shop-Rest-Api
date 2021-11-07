require 'rails_helper'

RSpec.describe "Cart Products Create Action", type: :request do
  context "when send post request" do
    let(:cart) { FactoryBot.create(:cart) }
    let(:product) { FactoryBot.create(:product, name: "Product 1", category_id: 1) }
    
    before { post "/carts/1/cart_product", :params => {:card_id => 1, :product_id => 1} } 

    it "returns status code 201" do
      expect(response).to have_http_status(201)
    end

    it "returns cart product" do
      parsed_response = JSON.parse(response.body)

      parsed_response["cart_id"].to eq(1)
      parsed_response["product_id"].to eq(1)
    end
  end

  context "when send invalid post request" do
    before { post "/carts/1/cart_product", :params => {:card_id => 999, :product_id => 999} }
    
    it "returns status code 400" do
      expect(response).to have_http_status(400)
    end

    it "returns error message" do
      expect(JSON.parse(response.body)["message"]).to eq("Validation failed")
    end
  end
end