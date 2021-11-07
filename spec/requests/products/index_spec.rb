require 'rails_helper'

RSpec.describe "Products Index Action", type: :request do
  let!(:categories) { 
    5.times do |i|
      FactoryBot.create(:category, name: "Category #{i + 1}")
    end
  }

  let!(:products) {
    50.times do |i|
      FactoryBot.create(
        :product,
        name: "Product #{i + 1}",
        price: i + 1,
        category_id: (i % 5) + 1
      )
    end
  }

  context "when send valid request without parameters" do
    before { get "/products" }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns paginated 25 items" do
      expect(JSON.parse(response.body).size).to eq(25)
    end

    it "returns first page of items" do
      expect(JSON.parse(response.body)[0]["id"]).to eq(1)
    end
  end

  context "when send valid request with page parameter" do
    before { get "/products", :params => {:pagination => {:page => 2} } }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns second page of items" do
      expect(JSON.parse(response.body)[0]["id"]).to eq(26)
    end
  end

  context "when send valid request with category filter parameter" do
    let(:category_name) { "Category 1" }

    before { get "/products", :params => {:filtering => {:category => category_name} }  }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 items" do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it "returns 10 items that belongs to parameter category" do
      expect(JSON.parse(response.body)[0]["category"]).to eq(category_name)
    end
  end

  context "when send valid request with price filter parameter" do
    before { get "/products", :params => {:filtering => {:price => {:from => 5, :to => 10} } } }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns 6 items" do
      expect(JSON.parse(response.body).size).to eq(6)
    end
  end

  context "when send invalid request with page parameter" do
    before { get "/products", :params => {:pagination => {:page => 22} } }

    it "returns status code 400" do
      expect(response).to have_http_status(400)
    end

    it "returns response with error" do
      expect(JSON.parse(response.body)["errors"].size).to eq(1)
    end
  end

  

  context "when send invalid request with empty category filter parameter" do
    before { get "/products", :params => {:filtering => {:category => nil } } }

    it "returns status code 400" do
      expect(response).to have_http_status(400)
    end

    it "returns response with error" do
      expect(JSON.parse(response.body)["errors"].size).to eq(1)
    end
  end

  context "when send invalid request price filter without both from and to parameters" do
    before { get "/products", :params => {:filtering => {:price => {:from => nil , :to => nil} } } }

    it "returns status code 400" do
      expect(response).to have_http_status(400)
    end

    it "returns response with error" do
      expect(JSON.parse(response.body)["errors"].size).to eq(1)
    end
  end
end
