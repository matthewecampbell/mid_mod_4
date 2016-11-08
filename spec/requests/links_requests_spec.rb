require "rails_helper"

RSpec.describe "Can visit links route" do
  it "loads redirects if you are not logged in" do

    get "/links"

    expect(response.status).to eq(302)
  end

  it "can change link status" do
    user = User.create!(email: 'example@example.com', password: 'password')
    link = Link.create!(url: 'http://www.google.com', title: "google", user: user, id: 1000)

    put "/read?link_id=1000"

    expect(response.status).to eq(200)
    expect(link.read).to eq(false)
  end

  it "can change link status" do
    user = User.create!(email: 'example@example.com', password: 'password')
    link = Link.create!(url: 'http://www.google.com', title: "google", user: user, id: 1000)

    put "/unread?link_id=1000"

    expect(response.status).to eq(200)
    expect(link.read).to eq(false)
  end
end
