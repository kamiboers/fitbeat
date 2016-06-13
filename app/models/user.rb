class User < ActiveRecord::Base
has_one :spotify_credential
has_one :fitbit_credential

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

end
