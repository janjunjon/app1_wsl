require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = Article.new(title: "test1",
                            author: "test_user",
                            year: 2000,
                            abstract: "a"*100)
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
    @article.year = 2023
    expect(@article.valid?).to be_falsey
  end

  it "abstract should be presence" do
    @article.abstract = ""
    expect(@article.valid?).to be_falsey
    @article.abstract = "a"*99
    expect(@article.valid?).to be_falsey
  end
end
