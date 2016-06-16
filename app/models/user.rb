class User < ActiveRecord::Base
  has_one :spotify_credential
  has_one :fitbit_credential
  has_many :playlists

  def self.sign_in_from_omniauth(auth)
    user = find_or_create_by( name: auth[:info][:name] )
    create_or_update_fitbit_credential(auth)
    return user
  end

  def add_spotify_data(auth)
    add_email_to_attributes(auth)
    create_or_update_spotify_credential(auth)
  end


  def self.create_or_update_fitbit_credential(auth)
     FitbitCredential.find_or_initialize_by( uid: auth[:uid] ).update_attributes!(
                      token: auth[:credentials][:token],
                      refresh_token: auth[:credentials][:refresh_token],
                      token_expiration: Time.at(auth[:credentials][:expires_at].to_i),
                      avatar_url: auth[:extra][:raw_info][:user][:avatar],
                      user_id: last.id )
  end

  def create_or_update_spotify_credential(auth)
    SpotifyCredential.find_or_initialize_by( uid: auth[:uid] ).update_attributes!(
                      token: auth[:credentials][:token],
                      refresh_token: auth[:credentials][:refresh_token],
                      token_expiration: Time.at(auth[:credentials][:expires_at].to_i),
                      avatar_url: auth[:info][:image],
                      user_id: self.id )
  end

  def add_email_to_attributes(auth)
    update!( email: auth[:info][:email] )
  end
  
  def fitbit_data
    raw_data = FitbitService.get_heart_data(fitbit_credential.uid, fitbit_credential.token)
    parsed_data = HeartData.new(raw_data)
    response = parsed_data.day_array.last if parsed_data.day_array
  end

  def refresh_spotify_token
    response = SpotifyService.get_refresh_token(spotify_credential.refresh_token)
    update_spotify_credentials(response) if response
  end

  def refresh_fitbit_token
    response = FitbitService.get_refresh_token(fitbit_credential.refresh_token)
    update_fitbit_credentials(response) if response
  end

  def update_spotify_credentials(response)
    spotify_credential.update!(token: response["access_token"], token_expiration: (DateTime.now + 1.hour))
    spotify_credential.update!(refresh_token: response["refresh_token"]) if response['refresh_token']
  end

  def update_fitbit_credentials(response)
    fitbit_credential.update!(token: response["access_token"], token_expiration: (DateTime.now + 1.hour))
    fitbit_credential.update!(refresh_token: response["refresh_token"]) if response['refresh_token']
  end

end