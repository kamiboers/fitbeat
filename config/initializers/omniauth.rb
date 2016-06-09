Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :spotify, ENV['SPOTIFY_ID'], ENV['SPOTIFY_KEY'], scope: 'playlist-read-private user-read-private playlist-modify-public playlist-modify-private user-read-email', response_type: 'code', redirect_uri: 'http://localhost:8080/auth/spotify/callback'

  provider :fitbit_oauth2, ENV['FITBIT_ID'], ENV['FITBIT_KEY'], response_type: 'code', scope: 'activity heartrate profile', redirect_uri: 'http://localhost:8080/auth/fitbit_oauth2/callback'

end