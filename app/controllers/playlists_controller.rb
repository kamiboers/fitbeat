class PlaylistsController < ApplicationController

  def create
    @user = current_user
    response = HTTParty.post "https://api.spotify.com/v1/users/#{@user.spotify_credential.uid}/playlists", headers: {"Authorization" => "Bearer #{@user.spotify_credential.token}", "Content-Type" => "application/json"}, body:  "{\"name\":\"#{params['playlist_name']} - FITBEAT\", \"public\":false}"
    binding.pry
    playlist = Playlist.new(response)
    redirect_to :controller => 'pages', :action => 'dashboard'

  end

end