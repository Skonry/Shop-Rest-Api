require 'rails_helper'

RSpec.describe "Products Index Action", type: :request do
  let(:categories) { 
    FactoryBot.create_list(:category, 1) do |category, i|
      category.name = "Category #{i + 1}"
    end
  }

  let(:products) {
    FactoryBot.create_list(:product, 10) do |product, i|
      product.name = "Product #{i + 1}"
      product.price = i + 1
      product.category_id = i
    end
  }

  context "when product exists"
    let(:product_name) { "Product 1" }
    get "/products/find", :params => {:product_name => product_name}

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns product named Product 1" do
      expect(JSON.parse(response.body).name.to eq(product_name)
    end
  end

  context "when product does not exist"
    let(:product_name) { "Invalid product name" }
    get "/products/find", :params => {:product_name => product_name}

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end
  end
end
 