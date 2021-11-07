require 'rails_helper'

RSpec.describe "Products Index Action", type: :request do
  let!(:categories) { 
    1.times do |i|
      FactoryBot.create(:category, name: "Category #{i + 1}")
    end
  }

  let!(:products) {
    10.times do |i|
      FactoryBot.create(
        :product,
        name: "Product #{i + 1}",
        price: i + 1,
        category_id: 1
      )
    end
  }

  context "when product exists" do
    let(:product_name) { "Product 1" }

    before { get "/products/find", :params => {:product_name => product_name} }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns product named Product 1" do
      expect(JSON.parse(response.body)["name"]).to eq(product_name)
    end
  end

  context "when product does not exist" do
    let(:product_name) { "Invalid product name" }

    before { get "/products/find", :params => {:product_name => product_name} }

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end
  end
end
 