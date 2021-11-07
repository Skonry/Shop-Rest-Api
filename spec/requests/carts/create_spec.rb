require 'rails_helper'

RSpec.describe "Carts Create Action", type: :request do
  context "when send post request" do
    before { post "/carts" }

    it "returns status code 201" do
      expect(response).to have_http_status(201)
    end
  end
end