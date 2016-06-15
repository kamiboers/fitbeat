class Track
attr_reader :name, :artist, :album, :spotify_id

def initialize(name, artist, album, spotify_id)
  @name = name
  @artist = artist
  @album = album
  @spotify_id = spotify_id
end

end