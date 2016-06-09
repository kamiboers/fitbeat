require 'rails_helper'

RSpec.describe "home page" do
  it "displays a welcome and login links" do
    visit root_path
    expect(page).to have_content("Welcome to FitBeat")
    expect(page).to have_button("Log in to Fitbit")
    expect(page).to have_button("Log in to Spotify")
  end
end