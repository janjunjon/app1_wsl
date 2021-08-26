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
      get '/users/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "create action should be worked" do
      post '/users', params: { user: { name: "test_user3",
                                              email: "test3@example.com",
                                              password: "password",
                                              password_confirmation: "password" } }
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "ユーザー認証のために、登録したメールアドレスを確認してください。"
    end
    it "should be rendered, if what you entered was invalid" do
      post '/users', params: { user: { name: "test_user3",
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
      get '/users/1'
      expect(response).to redirect_to login_path
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      get '/users/1'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      get '/users/1/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #update" do
    it "update should be worked" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      patch '/users/1', params: { user: { name: "test_user_update",
                                          email: "test@example.com" } }
      expect(response).to redirect_to user_path(1)
      patch '/users/1', params: { user: { name: "test_user",
                                          email: "test" } }
      expect(response).to render_template('users/edit')
    end
    it "images should be uploaded" do
    end
  end

  describe "DELETE #destroy" do
    it "users should be destroyed" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      delete '/users/1'
      expect(response).to redirect_to root_path
      expect(flash[:info]).to eq "ユーザーを削除しました。"
    end
  end

  describe "redirect" do
    it "should be redirected, if not correct user" do
      post '/login', params: { session: { email: "test2@example.com",
                                          password: "password" } }
      # expect(session[:user_id]).to eq 2
      get '/users/1/edit'
      expect(response).to redirect_to users_path
      patch '/users/1', params: { user: { name: "test_user",
                                          email: "test@example.com" } }
      expect(response).to redirect_to users_path
      delete '/users/1'
      expect(response).to redirect_to users_path
      expect(flash[:danger]).to eq "適性ユーザーではありません。"
    end
    it "should be redirected, if already logged in" do
      post '/login', params: { session: { email: "test@example.com",
                                          password: "password" } }
      get '/users/new'
      expect(response).to redirect_to root_path
      post '/users', params: { user: { name: "test_user3",
                                              email: "test3@example.com",
                                              password: "password",
                                              password_confirmation: "password" } }
    end
  end
end
