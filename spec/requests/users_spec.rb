require 'rails_helper'

RSpec.describe "Users", type: :request do
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
  describe "GET #new" do
    it "returns http success" do
      get 'users/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "create action should be worked" do
      post '/users/create', params: { user: { name: "test_user3",
                                              email: "test3@example.com",
                                              password: "password",
                                              password_confirmation: "password" } }
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "ユーザー認証のために、登録したメールアドレスを確認してください。"
    end
    it "should be rendered, if what you entered was invalid" do
      post '/users/create', params: { user: { name: "test_user3",
                                              email: "test3",
                                              password: "password",
                                              password_confirmation: "" } }
      expect(response).to render_template('users/new')
      expect(flash[:danger]).to eq '入力情報が有効ではありません。'
    end
  end

  describe "GET #index" do
    it "users should be displayed with desc, limit 30" do
      get '/users'
      expect(response).to redirect_to login_path
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #update" do
    it "update should be worked" do
    end
    it "images should be uploaded" do
    end
    it "should be rendered, if can not updated" do
    end
  end

  describe "DELETE #destroy" do
    it "users should be destroyed" do
    end
  end

  describe "redirect" do
    it "should be redirected to lagis authentication" do
    end
    it "should be redirected to login_path" do
    end
    it "should be redirected, if not correct user" do
    end
    it "should be redirected, if already logged in" do
    end
  end
end
