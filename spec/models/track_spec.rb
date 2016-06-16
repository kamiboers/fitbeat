require 'rails_helper'

RSpec.describe Track, type: :model do
  it "initializes with parameters" do
    track = Track.new("name", "artist", "album", "spotify_id")

    expect(track.name).to eq("name")
    expect(track.artist).to eq("artist")
    expect(track.album).to eq("album")
    expect(track.spotify_id).to eq("spotify_id")
  end
end