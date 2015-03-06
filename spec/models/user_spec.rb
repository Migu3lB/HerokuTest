require "rails_helper"

RSpec.describe User, :type => :model do

  before do
    stub_user
  end

  it "creates an user" do
    user = User.create(name: "Andy")
    expect(user.persisted?).to be true
  end

  it "orders by last name" do
    user = User.create(name: "Andy", email: 'asdadads')
    expect(user.persisted?).to be false
    expect(user).to have(1).error_on(:email)
  end

end