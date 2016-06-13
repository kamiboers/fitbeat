class PlaylistsController < ApplicationController

  def create
    @user = current_user
    response = HTTParty.post "https://api.spotify.com/v1/users/#{@user.spotify_credential.uid}/playlists", headers: {"Authorization" => "Bearer #{@user.spotify_credential.token}", "Content-Type" => "application/json"}, body:  "{\"name\":\"#{params['playlist_name']} - FITBEAT\", \"public\":false}"
    @playlist = PlaylistManager.create(response, @user.id)
    redirect_to :controller => 'pages', :action => 'dashboard'
  end

  def index
    @playlists = Playlist.where(user_id: current_user.id)
  end

end