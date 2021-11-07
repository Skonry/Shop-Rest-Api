require 'rails_helper'

RSpec.describe "Carts Show Action", type: :request do
  context "when cart exists" do
    let(:cart) { Cart.create() }

    before { get "/carts/#{cart.id}" }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns cart" do
      expect(JSON.parse(response.body)["id"]).to eq(cart.id)
    end
  end

  context "when cart does not exist" do
    before {get "/carts/999"}

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end
  end

  context "when added products to cart" do
    let(:cart) { Cart.create() }
    let(:category) { FactoryBot.create(:category, name: "Category 1") }

    it "returns total price of cart" do
      
      cart.products << FactoryBot.create(:product, name: "Product 1", category_id: category.id, price: 10.0)
      cart.products << FactoryBot.create(:product, name: "Product 2", category_id: category.id, price: 20.0)
      cart.products << FactoryBot.create(:product, name: "Product 3", category_id: category.id, price: 30.0)

      get "/carts/#{cart.id}"

      expect(JSON.parse(response.body)["total_price"]).to eq("60.0")
    end
  end
end