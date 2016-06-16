class PlaylistManager

def self.create_playlist(user, intensity, name)
  data = SpotifyService.create_playlist(user.spotify_credential.uid, user.spotify_credential.token, name)
  Playlist.create!( name: data['name'], spotify_id: data['id'], user_id: user.id, intensity: intensity )
end

def self.retrieve_playlist(user, playlist_id)
  raw_tracks = SpotifyService.get_playlist(user.spotify_credential.uid, playlist_id, user.spotify_credential.token)
  if raw_tracks
  tracks = raw_tracks.map { |t| Track.new( t['track']['name'], 
                                            t['track']['artists'].first['name'], 
                                            t['track']['album']['name'], 
                                            t['track']['id'] ) }
end
end

def self.populate_playlist(spotify_id, genre, intensity, user)
   if genre.include?(" ")
      response1 = SpotifyService.search_with_quotes(genre)
      response2 = SpotifyService.search_with_quotes(genre, 50)
    else
      response1 = SpotifyService.search_with_quotes(genre)
      response2 = SpotifyService.search_with_quotes(genre, 50)
    end

    result1 = response1.map { |track| [track['id'],track['name']] }
    result2 = response2.map { |track| [track['id'],track['name']] }
    result = result1.to_h.merge(result2.to_h)
    id_string = result.keys.join(',')

    response3 = SpotifyService.get_audio_features(id_string, user.spotify_credential.token)
    result3 = response3['audio_features'].map { |track| [track['id'],track['tempo']] }
    tracks = result3.select { |a,b| [a,b] if (90..140).include?(b) }
    uris = tracks.to_h.keys.map { |i| "spotify:track:#{i}"}.join(',')

    response4 = SpotifyService.add_songs_to_playlist(user.spotify_credential.uid, spotify_id, user.spotify_credential.token, uris)

end

end