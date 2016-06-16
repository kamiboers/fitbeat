class SpotifyService

  def self.get_refresh_token(token)
    auth = Base64.strict_encode64("#{ENV['SPOTIFY_ID']}:#{ENV['SPOTIFY_KEY']}")
    HTTParty.post "https://accounts.spotify.com/api/token", 
                   headers: {"Authorization" => "Basic #{auth}"}, 
                   body:  {grant_type: 'refresh_token', expires_in: 3600, refresh_token: token}
  end

  def self.create_playlist(uid, token, name)
    response = HTTParty.post "https://api.spotify.com/v1/users/#{uid}/playlists", 
                        headers: { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" }, 
                        body: "{\"name\":\"#{name} - FITBEAT\", \"public\":false}"
  end

  def self.get_playlist(uid, playlist_id, token)
    (HTTParty.get "https://api.spotify.com/v1/users/#{uid}/playlists/#{playlist_id}/tracks", headers: {"Authorization" => "Bearer #{token}"})['items']
  end

  def self.search_with_quotes(genre, offset=0)
    (HTTParty.get "https://api.spotify.com/v1/search?q=genre:\"#{genre}\"&type=track&limit=50&offset=#{offset.to_s}")['tracks']['items']
  end

  def self.search_without_quotes(genre, offset=0)
    (HTTParty.get "https://api.spotify.com/v1/search?q=genre:#{genre}&type=track&limit=50&offset=#{offset.to_s}")['tracks']['items']
  end

  def self.get_audio_features(id_string, token)
    HTTParty.get "https://api.spotify.com/v1/audio-features/?ids=#{id_string}", headers: {"Authorization" => "Bearer #{token}"}
  end

  def self.add_songs_to_playlist(uid, spotify_id, token, uris)
    HTTParty.post "https://api.spotify.com/v1/users/#{uid}/playlists/#{spotify_id}/tracks?uris=#{uris}", headers: {"Authorization" => "Bearer #{token}"}
  end

end