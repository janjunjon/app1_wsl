require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
    it "should be displayed 10 researches in first paginate" do
        get :index
        expect(response).to have_http_status(:success)
        # expect(response.body).to include Article.all.paginate(page: 1)
    end

    it "should be displayed each article page" do
        # get :show
        # expect(response).to have_http_status(:success)
        # expect(response.body).to include Article.all.paginate(page: 1)
    end
end
