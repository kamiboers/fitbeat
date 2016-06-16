class PlaylistManager

  def self.create_playlist(user, intensity, name)
    data = SpotifyService.create_playlist(user.spotify_credential.uid, user.spotify_credential.token, name)
    Playlist.create!( name: data['name'], spotify_id: data['id'], user_id: user.id, intensity: intensity )
  end

  def self.retrieve_playlist(user, playlist_id)
    raw_tracks = SpotifyService.get_playlist(user.spotify_credential.uid, playlist_id, user.spotify_credential.token)
    create_track_objects(raw_tracks) if raw_tracks
  end

  def self.create_track_objects(raw_tracks)
    tracks = raw_tracks.map { |t| Track.new( t['track']['name'], 
      t['track']['artists'].first['name'], 
      t['track']['album']['name'], 
      t['track']['id'] ) }
  end

  def self.populate_playlist(spotify_id, genre, intensity, user)
    if genre.include?(" ")
      response1 = SpotifyService.search_with_quotes(genre)
      response2 = SpotifyService.search_with_quotes(genre, 50)
    else
      response1 = SpotifyService.search_with_quotes(genre)
      response2 = SpotifyService.search_with_quotes(genre, 50)
    end
    id_string = concatenate_responses(response1, response2).keys.join(',')
    track_tempos = retrieve_bpm_of_tracks(id_string, user.spotify_credential.token)
    tracks = select_appropriate_tempos_for_playlist(intensity, track_tempos)
    uris = tracks.to_h.keys.map { |i| "spotify:track:#{i}"}.join(',')
    response4 = SpotifyService.add_songs_to_playlist(user.spotify_credential.uid, spotify_id, user.spotify_credential.token, uris)
  end

  def self.select_appropriate_tempos_for_playlist(intensity, track_tempos)
    case intensity
    when 'high'
      track_tempos.select { |a,b| [a,b] if (161..220).include?(b) }
    when 'med'
      track_tempos.select { |a,b| [a,b] if (133..160).include?(b) }
    when 'low'
      track_tempos.select { |a,b| [a,b] if (95..132).include?(b) }
    when 'rest'
      track_tempos.select { |a,b| [a,b] if b < 95 }
    else
      track_tempos
    end
  end

  def self.retrieve_bpm_of_tracks(id_string, token)
    track_details = SpotifyService.get_audio_features(id_string, token)
    track_tempos = track_details['audio_features'].map { |track| [track['id'],track['tempo']] }
  end

  def self.concatenate_responses(response1, response2)
    result1 = response1.map { |track| [track['id'],track['name']] }
    result2 = response2.map { |track| [track['id'],track['name']] }
    result = result1.to_h.merge(result2.to_h)
  end

end