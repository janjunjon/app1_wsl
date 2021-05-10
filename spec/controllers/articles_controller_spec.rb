require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
    before do
        @article1 = Article.new(title: "test_paper1",
                                abstract: "a"*100,
                                author: "テスト太郎",
                                year: 2020,
                                degree: "学士",
                                romaji_name: "test_taro"
                                )

        @article2 = Article.new(title: "test_paper2",
                                abstract: "b"*100,
                                author: "テスト次郎",
                                year: 2015,
                                degree: "修士",
                                romaji_name: "test_jiro"
                                )
    end

    describe "GET #index" do
        it "should be displayed 10 researches in first paginate" do
            get :index
            # expect(response).to have_http_status(:success)
            expect(response.body).to include @article1.title
        end
    end

    describe "GET #search" do
        it "should be displayed what you want in search" do
            get :search
            get :search, params: {degree: "学士", year: 2020, keyword: "a"}
            expect(response.body).to include @article1
            expect(response.body).not_to include @article2
        end
    end

    describe "GET #download" do
        it "should be displayed PDF download link" do
        end
        it "correct paper should be downloaded" do
        end
    end

    describe "GET #redirect" do
        it "should be redirected to lagis authentication" do
        end
        it "should be redirected to login path" do
        end
    end
end
