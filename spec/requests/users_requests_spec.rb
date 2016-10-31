require "rails_helper"

RSpec.describe "Can visit new user route" do
  it "loads properly" do

    get "/users/new"

    expect(response.status).to eq(200)
  end
end
