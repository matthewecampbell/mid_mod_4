require "rails_helper"

RSpec.feature "User has functionalities for links", :type => :feature do
  scenario "Logged in user can create link" do
    user = User.create!(email: 'example@example.com', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/'
    expect(page).to have_content("Log out")

    visit '/links'

    fill_in "url", :with => "https://www.google.com"
    fill_in "Title", :with => "Google"
    click_button "Create Link"

    expect(page).to have_content("Link Created.")
  end

  # scenario "Logged in user cannot create link with invalid URL" do
  #   user = User.create!(email: 'example@example.com', password: 'password')
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #   visit '/'
  #   expect(page).to have_content("Log out")
  #
  #   visit '/links'
  #
  #   fill_in "url", :with => "httpwww.googlecom"
  #   fill_in "Title", :with => "Google"
  #   click_button "Create Link"
  #   # 
  #   expect(page).to have_content("Please enter a valid URL.")
  # end
end
