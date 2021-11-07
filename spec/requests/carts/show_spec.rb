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
end