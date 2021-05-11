require 'rails_helper'

RSpec.describe CodesController, type: :controller do
    before do
        password = "authentication"
        @code = Code.new(classification: "test_authentication",
                         password: password,
                         password_confirmation: password)
    end

    describe "GET #index" do 
        it "GET #index" do
            get :index
            expect(response).to have_http_status(200)
        end
    end

    describe "POST #post" do
        it "should be rendered to index, if password was wrong" do
            password = "authentication"
            post :post, params: { code: { password: password, password_confirmation: password } }
            expect(response).to redirect_to root_path
        end
        it "should be redirected to root, if authentication was success" do
        end
    end
end
