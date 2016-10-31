require "rails_helper"

RSpec.feature "User has functionalities for links", :type => :feature do
  scenario "Logged in user can change read status for link" do
    user = User.create!(email: 'example@example.com', password: 'password')
    link = Link.create!(url: 'http://www.google.com', title: "google", user: user)
    link = Link.create!(url: 'http://www.google.com', title: "flooooble", user: user, read: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/links'

    expect(page).to have_content("google")
    expect(page).to have_content("False")

    click_on "Mark as Read"

    click_on "Mark as Unread"

    expect(page).to have_content("False")
    expect(page).to have_content("True")
  end
end
