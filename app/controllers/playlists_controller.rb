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
  end

  def populate
    genre = params[:genre] || "dance"
    response = HTTParty.get "https://api.spotify.com/v1/search?q=a&genre:#{genre}&type=track&limit=50"
    result = response['tracks']['items'].map { |track| track['id'] }.join(',')
    binding.pry
    
    response = HTTParty.get "https://api.spotify.com/v1/search?q=a&genre:#{genre}&type=track&limit=50"

  end

end