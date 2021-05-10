require 'rails_helper'

RSpec.describe Code, type: :model do
  before do
    @code = Code.new(classification: "lagis",
                      password: "password",
                      password_confirmation: "password")
  end

  it "classification should be presence" do
    @code.classification = ""
    expect(@code.valid?).to be_falsey
  end

  it "password should be presence" do
    @code.password_digest = ""
    expect(@code.valid?).to be_falsey
  end
end
