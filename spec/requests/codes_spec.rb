require 'rails_helper'

RSpec.describe "Codes", type: :request do
  before do
    password = "test_authentication"
    @code = Code.new(classification: "test_authentication",
                     password: password,
                     password_confirmation: password).save
  end
  describe "GET /index" do
    it "returns http success" do
      get '/lagis'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /post" do
    it "should be rendered to code/index" do
      post '/lagis', params: { code: { password: "test_authentication",
                                       password_confirmation: "test_authentication"} }
      expect(response).to redirect_to(root_path)
      expect(flash[:success]).to eq "Lagisの認証コードが確認できました。"
    end
    it "should be redirected, if lagis authentication code was correct" do
      post '/lagis', params: { code: { password: "incorrect",
                                       password_confirmation: "incorrect"} }
      expect(response).to render_template('codes/index')
      expect(flash.empty?).to be_truthy
    end
  end
end
