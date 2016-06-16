require 'rails_helper'

RSpec.describe User, type: :model do
  it "can get refresh token from spotify" do
    VCR.use_cassette('spotify_refresh') do
      user = create_user
      allow_any_instance_of(User).to receive(:spotify_credential).and_return(spotify_cred_standin)
      original_token = user.spotify_credential.token
      
      user.refresh_spotify_token

      new_token = user.spotify_credential.token

      expect(new_token).not_to eq(original_token)
    end
  end


end