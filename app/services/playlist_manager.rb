class PlaylistManager

def create(data, user_id)
  Playlist.create( name: data['name'], spotify_id: data['id'], user_id: user_id )
end


end