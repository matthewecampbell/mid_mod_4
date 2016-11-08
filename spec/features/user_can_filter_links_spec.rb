# require 'rails_helper'
#
# RSpec.feature "User can alphabatize" do
#   scenario "user clicks alphabatize button", :js => true do
#     user = User.create(email: "ClayMatthews", password: "password")
#     user.links.create(title: "boy", url: "https://www.packers.com")
#     user.links.create(title: "apple", url: "https://www.packers.com")
#     user.links.create(title: "car", url: "https://www.packers.com")
#     user.links.create(title: "elephant", url: "https://www.packers.com")
#     user.links.create(title: "dog", url: "https://www.packers.com")
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#     visit links_path
#
#     click_button("Sort Alphabetically")
#
#     links = page.all(".link")
#
#     expect(links[0].find(".title").text).to have_content "apple"
#     expect(links[1].find(".title").text).to have_content "boy"
#   end
# end
