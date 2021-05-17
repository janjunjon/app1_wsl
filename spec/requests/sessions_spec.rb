require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "should be rendered to sessions/new, if user nil, or password is incorrect" do
    end
    it "should be redirected to root, if not activated user" do
    end
    it "should be remember, if parameter includes 1" do
    end
    it "should be rendered to sessions/new if user nil, or password is incorrect" do
    end
    it "should be redirected current url if session is not nil" do
    end
  end

  describe "DELETE #destroy" do
    it "should be logged out" do
    end
  end
end
