require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = User.new(name: "test_user",
                      email: "tmu@example.com",
                      password: "testtest",
                      password_confirmation: "testtest")
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "create action should be worked" do
    end
    it "should be rendered, if what you entered was invalid" do
    end
  end

  describe "GET #index" do
    it "users should be displayed with desc, limit 30" do
    end
  end

  describe "GET #show" do
    it "returns http success" do
      log_in_as(@user)
      get :show
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
