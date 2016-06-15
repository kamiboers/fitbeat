require 'base64'
class User < ActiveRecord::Base
has_one :spotify_credential
has_one :fitbit_credential
has_many :playlists
attr_accessor :logged_fitbit

  def self.sign_in_from_omniauth(auth)
   create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    user = find_or_create_by(
      name: auth[:info][:name]
      )
    FitbitCredential.find_or_initialize_by(
        uid: auth[:uid]).update_attributes!(
        token: auth[:credentials][:token],
        refresh_token: auth[:credentials][:refresh_token],
        token_expiration: Time.at(auth[:credentials][:expires_at].to_i),
        avatar_url: auth[:extra][:raw_info][:user][:avatar],
        user_id: last.id
      )
      user.logged_fitbit = true
      return user
  end

  def add_spotify_data(auth)
    update!(email: auth[:info][:email])
    SpotifyCredential.find_or_initialize_by(
        uid: auth[:uid]).update_attributes!(
        token: auth[:credentials][:token],
        refresh_token: auth[:credentials][:refresh_token],
        token_expiration: Time.at(auth[:credentials][:expires_at].to_i),
        avatar_url: auth[:info][:image],
        user_id: self.id
      )
  end

  def fitbit_data
    FitgemOauth2::Client.new(
      token: fitbit_credential.token,
      client_id: ENV['FITBIT_ID'],
      client_secret: ENV['FITBIT_KEY'],
      user_id: fitbit_credential.uid
    )
  end

  def refresh_spotify
    key = spotify_credential.refresh_token
    auth = Base64.strict_encode64("f5411bb0e70f4e518099e5143211d26d:ed64b3ff56084285aa612af3b00ece08")
    response = HTTParty.post "https://accounts.spotify.com/api/token", headers: {"Authorization" => "Basic #{auth}"}, body:  {grant_type: 'refresh_token', expires_in: 36000, refresh_token: key}
    spotify_credential.update!(token: response["access_token"], token_expiration: (DateTime.now + 1.hour))
    spotify_credential.update!(refresh: response["refresh_token"]) if response['refresh_token']
  end

  def logged_spotify
    @logged_spotify ||= false
  end

end
