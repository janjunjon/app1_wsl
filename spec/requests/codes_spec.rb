require 'rails_helper'

RSpec.describe "Codes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/codes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /post" do
    it "should be rendered to code/index" do
    end
    it "should be redirected, if lagis authentication code was correct" do
    end
  end
end
