require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = Article.new(title: "test_paper1",
                            abstract: "a"*100,
                            author: "テスト太郎",
                            year: 2020,
                            degree: "学士",
                            romaji_name: "test_taro"
                            )
  end

  it "all elements should be presence" do
    expect(@article.valid?).to be_truthy
  end

  it "title should be presence" do
    @article.title = ""
    expect(@article.valid?).to be_falsey
  end

  it "author should be presence" do
    @article.author = ""
    expect(@article.valid?).to be_falsey
  end

  it "year should be less than 2023" do
    @article.year = nil
    expect(@article.valid?).to be_falsey
    @article.year = 2023
    expect(@article.valid?).to be_falsey
  end

  it "abstract should be presence" do
    @article.abstract = ""
    expect(@article.valid?).to be_falsey
    @article.abstract = "a"*99
    expect(@article.valid?).to be_falsey
  end

  it "degree should be presence" do
    @article.degree = ""
    expect(@article.valid?).to be_falsey
  end

  it "romaji name should be presence" do
    @article.romaji_name = ""
    expect(@article.valid?).to be_falsey
  end
end
