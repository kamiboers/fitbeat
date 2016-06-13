require 'rails_helper'

RSpec.describe "home page" do
  it "displays a welcome and login links" do
    user = create_user
    allow(controller).to receive(:current_user).and_return(user)
    
    expect(user.playlists.count).to eq(0)

    visit dashboard_path
    fill_in :playlist_name, with: "Pure Leaf Tea House"
    click_on "Create"

    expect(page).to have_content("Pure Leaf Tea House")
    expect(page).to have_button("Playlist Created")
    expect(user.playlists.count).to eq(1)
  end
end