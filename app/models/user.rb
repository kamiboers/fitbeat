class User < ActiveRecord::Base

  def self.sign_in_from_omniauth(auth)
    find_by(spotify_uid: auth['spotify_uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create!(
      name: auth[:info].name,
      avatar_url: auth[:extra][:raw_info][:avatar],
      fitbit_uid: auth[:uid],
      fitbit_token: auth['credentials']['token'],
      )
  end

  def add_spotify_data(auth)
    binding.pry
  end

end

##### SEND ILANA TOOLCHEST STYLING STUFF