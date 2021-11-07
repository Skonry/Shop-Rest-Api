require 'rails_helper'

RSpec.describe "Carts Complete Action", type: :request do
  context "when cart exists" do
    let(:cart) { Cart.create() }

    before { post "/cart/#{cart.id}/complete" }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns cart" do
      expect(JSON.parse(response.body)["message"]).to eq("Shopping complited")
    end

    it "destroy cart" do
      post "/cart/#{cart.id}"

      expect(response).to have_http_status(404)
    end
  end

  context "when cart does not exist" do
    before {get "/cart/999/complete"}

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end
  end
end