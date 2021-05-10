require 'rails_helper'

RSpec.describe News, type: :model do
  before do
    @news = News.new(title: "APP",
                      contents: "テストリリースされました。",
                      info: "commodity")
  end

  it "title should be presence / length limit 6 characters" do
    @news.title = ""
    expect(@news.valid?).to be_falsey
    @news.title = "a"*7
    expect(@news.valid?).to be_falsey
  end

  it "contents should be presence" do
    @news.contents = ""
    expect(@news.valid?).to be_falsey
  end

  it "info should be presence" do
    @news.info = ""
    expect(@news.valid?).to be_falsey
  end
end
