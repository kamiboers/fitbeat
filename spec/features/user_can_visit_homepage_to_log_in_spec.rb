require 'rails_helper'

RSpec.describe "home page" do
  it "displays a welcome and login link when user not logged in" do
    visit root_path

    expect(page).to have_content("Welcome to FitBeat")
    expect(page).to have_button("Sign in with")
  end

  it "displays dashboard link when user logged in" do
    VCR.use_cassette("dashboard") do
    user = create_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(User).to receive(:fitbit_credential).and_return(standin_credential)
    allow_any_instance_of(User).to receive(:spotify_credential).and_return(standin_credential)

    visit root_path

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logout")
  end
  end

  it "displays spotify login when current user" do
    user = create_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit spotify_login_path

    expect(current_path).to eq('/spotify_login')
    expect(page).to have_content("Hey, #{user.name}")
    expect(page).to have_content("Sign into")
  end

end