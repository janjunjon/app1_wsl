require 'rails_helper'

RSpec.describe "Sessions", type: :request do
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
                     password: password,
                     password_confirmation: password).save
    post '/lagis', params: { code: { password: password,
                                     password_confirmation: password} }
  end
  describe "GET /new" do
    it "returns http success" do
      get "/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "should be rendered to sessions/new, if user nil, or password is incorrect" do
      post '/login', params: { session: { email: "test3@example.com",
                                          password: "password" } }
      expect(response).to render_template('sessions/new')
      expect(flash[:danger]).to eq "メールアドレス・パスワードが適切ではありません。"
    end
    it "should be redirected to root, if not activated user" do
      post '/login', params: { session: { email: "test2@example.com",
                                          password: "password" } }
      expect(response).to redirect_to root_path
      expect(flash[:danger]).to eq "アカウントが有効化されていません。"
    end
    it "should be remember, if parameter includes 1" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password",
                                          remember: 1 } }
      expect(cookies[:user_id].nil?).not_to be_truthy
    end
    it "should be redirected to current url if session is not nil" do
      get '/users'
      expect(response).to redirect_to login_path
      expect(flash[:danger]).to eq "ログインしてください。"
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      expect(flash[:success]).to eq "ログインしました。"
      expect(response).to redirect_to users_path
    end
    it "should be redirected to root if session is nil" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      expect(flash[:success]).to eq "ログインしました。"
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE #destroy" do
    it "should be logged out" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      delete '/logout'
      expect(flash[:success]).to eq "ログアウトしました。"
      expect(response).to redirect_to root_path
    end
  end

  describe "when already logged in" do
    it "should be redirected to root if you have already logged in" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      get '/login'
      expect(response).to redirect_to root_path
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      expect(response).to redirect_to root_path
    end
  end
end
