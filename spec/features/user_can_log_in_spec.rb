require "rails_helper"

RSpec.feature "User can create account", :type => :feature do
  scenario "User visits home page and creates a user" do
    visit "/"

    expect(page).to have_content("Log in or Sign Up")

    click_on "Sign Up"

    expect(current_path).to eq('/users/new')

    fill_in "Email", :with => "example@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Create User"

    expect(current_path).to eq("/links")
    expect(page).to have_text("Account Created.")
  end

  scenario "User log in with account" do
    visit "/"

    expect(page).to have_content("Log in or Sign Up")

    click_on "Sign Up"

    expect(current_path).to eq('/users/new')

    fill_in "Email", :with => "example@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Create User"

    expect(current_path).to eq("/links")
    expect(page).to have_text("Account Created.")

    visit '/logout'

    visit '/'

    click_on "Log in"

    expect(current_path).to eq('/login')

    fill_in "Email", :with => "example@example.com"
    fill_in "Password", :with => "password"
    click_button "Log in"

    expect(current_path).to eq("/links")
  end

  scenario "User mistypes email" do
    visit "/"

    expect(page).to have_content("Log in or Sign Up")

    click_on "Sign Up"

    expect(current_path).to eq('/users/new')

    fill_in "Email", :with => "example@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Create User"

    expect(current_path).to eq("/links")
    expect(page).to have_text("Account Created.")

    visit '/logout'

    visit '/'

    click_on "Log in"

    expect(current_path).to eq('/login')

    fill_in "Email", :with => "exampleeee@example.com"
    fill_in "Password", :with => "password"
    click_button "Log in"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Wrong Email or Password Log in Email Password Not Registered? Create an Account")
  end

  scenario "Visitor cannot create an account with duplicate email" do
    visit "/"

    expect(page).to have_content("Log in or Sign Up")

    click_on "Sign Up"

    expect(current_path).to eq('/users/new')

    fill_in "Email", :with => "example@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Create User"

    expect(page).to have_text("Account Created")

    visit '/logout'

    visit "/"

    expect(page).to have_content("Log in or Sign Up")

    click_on "Sign Up"

    expect(current_path).to eq('/users/new')

    fill_in "Email", :with => "example@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Create User"

    expect(page).to have_text("Email is already used or password does not match. Signup for URLockbox! Email Password Password confirmation")
  end
end
