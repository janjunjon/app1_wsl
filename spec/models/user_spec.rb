require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = User.new(name: "test_user",
                      email: "tmu@example.com",
                      password: "testtest",
                      password_confirmation: "testtest")
  end

  it "user should be valid" do
    expect(@user.valid?).to be_truthy
  end

  it "name should be presence, and less than 20 characters" do
    @user.name = ""
    expect(@user.valid?).to be_falsey
    @user.name = "a"*21
    expect(@user.valid?).to be_falsey
  end

  it "email should be presence, correct format" do
    @user.email = ""
    expect(@user.valid?).to be_falsey
    @user.email = "xxx.xxx.com"
    expect(@user.valid?).to be_falsey
  end

  it "password should be correspond to confirmation" do
    @user.password = "xxxxxx"
    @user.password_confirmation = "ffffff"
    expect(@user.valid?).to be_falsey
  end

  it "password should be more than 6 characters" do
    @user.password = "xxxxx"
    @user.password_confirmation = "xxxxx"
    expect(@user.valid?).to be_falsey
  end
end
