class PlaylistsController < ApplicationController

  def create
    @user = current_user
    response = HTTParty.post "https://api.spotify.com/v1/users/#{@user.spotify_credential.uid}/playlists", headers: {"Authorization" => "Bearer #{@user.spotify_credential.token}", "Content-Type" => "application/json"}, body:  "{\"name\":\"#{params['playlist_name']} - FITBEAT\", \"public\":false}"
    @playlist = PlaylistManager.create_playlist(response, @user.id, params['intensity'])
    redirect_to playlist_path(@playlist)
  end

  def index
    @playlists = current_user.playlists
  end

  def show
    @playlist = current_user.playlists.find(params[:id])
    raw_tracks = (HTTParty.get "https://api.spotify.com/v1/users/#{current_user.spotify_credential.uid}/playlists/#{@playlist.spotify_id}/tracks", headers: {"Authorization" => "Bearer #{current_user.spotify_credential.token}"})['items']
    @tracks = raw_tracks.map { |t| Track.new( t['track']['name'], t['track']['artists'].first['name'], t['track']['album']['name'], t['track']['id'] ) }
  end

  def populate
    genre = params[:genre] || "classical"
    @playlist = Playlist.find(params['playlist_id'])
    intensity = @playlist.intensity

    if genre.include?(" ")
    response1 = (HTTParty.get "https://api.spotify.com/v1/search?q=genre:\"#{genre}\"&type=track&limit=50")['tracks']['items']
    response2 = (HTTParty.get "https://api.spotify.com/v1/search?q=genre:\"#{genre}\"&type=track&limit=50&offset=50")['tracks']['items']
    else
    response1 = (HTTParty.get "https://api.spotify.com/v1/search?q=genre:#{genre}&type=track&limit=50")['tracks']['items']
    response2 = (HTTParty.get "https://api.spotify.com/v1/search?q=genre:#{genre}&type=track&limit=50&offset=50")['tracks']['items']
    end

    result1 = response1.map { |track| [track['id'],track['name']] }
    result2 = response2.map { |track| [track['id'],track['name']] }
    result = result1.to_h.merge(result2.to_h)
    id_string = result.keys.join(',')

    response3 = HTTParty.get "https://api.spotify.com/v1/audio-features/?ids=#{id_string}", headers: {"Authorization" => "Bearer #{current_user.spotify_credential.token}"}
    result3 = response3['audio_features'].map { |track| [track['id'],track['tempo']] }
    tracks = result3.select { |a,b| [a,b] if (90..140).include?(b) }
    uris = tracks.to_h.keys.map { |i| "spotify:track:#{i}"}.join(',')

    response4 = HTTParty.post "https://api.spotify.com/v1/users/#{current_user.spotify_credential.uid}/playlists/#{@playlist.spotify_id}/tracks?uris=#{uris}", headers: {"Authorization" => "Bearer #{current_user.spotify_credential.token}"}
    
    raw_tracks = (HTTParty.get "https://api.spotify.com/v1/users/#{current_user.spotify_credential.uid}/playlists/#{@playlist.spotify_id}/tracks", headers: {"Authorization" => "Bearer #{current_user.spotify_credential.token}"})['items']
    @tracks = raw_tracks.map { |t| Track.new( t['track']['name'], t['track']['artists'].first['name'], t['track']['album']['name'], t['track']['id'] ) }

    render :show
  end

end