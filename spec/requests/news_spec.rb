require 'rails_helper'

RSpec.describe "News", type: :request do
  before do
    password = "password"
    @code = Code.new(classification: "test_authentication",
                     password: password,
                     password_confirmation: password).save
    @user = User.new(name: "test_user",
                     email: "test@example.com",
                     activated: true,
                     admin: true,
                     password: password,
                     password_confirmation: password).save
    @user2 = User.new(name: "test_user2",
                     email: "test2@example.com",
                     activated: true,
                     password: password,
                     password_confirmation: password).save
    @news = News.new(title: "APP",
                     contents: "It was released.",
                     info: "commodity").save
    post '/lagis', params: { code: { password: password,
                                     password_confirmation: password} }
  end

  describe "GET /new" do
    it "returns http success" do
      log_in @user
      get "/news/new"
      expect(response).to have_http_status(:success)
    end
    it "redirected to root if not admin user" do
      log_in @user2
      get "/news/new"
      expect(response).to redirect_to root_path
    end
  end

  describe "POST /create" do
    it "news can be posted by admin user" do
      log_in @user
      post '/news', params: {title: "test", contents: "This is a test.", info: "test"}
      expect(response).to redirect_to(root_path)
      expect(flash[:info]).to eq 'you success post news.'
    end
    it "rendered if post was invalid" do
      log_in @user
      post '/news', params: {title: "test"}
      expect(response).to render_template('news/new')
      expect(flash[:danger]).to eq "what you posted was invalid."
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /past" do
    it "returns http success" do
      get "/news/past"
      expect(response).to have_http_status(:success)
    end
  end

end
