require 'rails_helper'

describe SpotifyService, type: :service do

  describe '#refresh_token' do
  
    it 'updates a user token and refresh token via fitbit api' do
      VCR.use_cassette('spotify_token_refresh') do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:spotify_credential).and_return(spotify_cred_standin)
      original_token = user.spotify_credential.token

      user.refresh_spotify_token

      expect(user.spotify_credential.token).not_to eq(original_token)      
    end
    end
  end

end