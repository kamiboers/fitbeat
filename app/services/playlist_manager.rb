class PlaylistManager

def self.create_playlist(data, user_id, intensity)
  Playlist.create!( name: data['name'], spotify_id: data['id'], user_id: user_id, intensity: intensity )
end


end