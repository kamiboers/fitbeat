require 'rails_helper'

RSpec.describe "fitbit login" do
  it "allows user to login to fitbit using oauth" do
    visit root_path
    click_on "Log In to Fitbit"
    
    expect(rendered).to have_css("cover-heading", text: "Hello, ")
    expect(rendered).to have_css("lead", text: "Sign in")
    
  end
end