class PlaylistsController < ApplicationController

  def create
    @user = current_user
    @playlist = PlaylistManager.create_playlist(@user, params['intensity'], params['playlist_name'])

    redirect_to playlist_path(@playlist)
  end

  def show
    @playlist = current_user.playlists.find(params[:id])
    @tracks = @playlist.tracks || []
  end

  def populate
    @playlist = Playlist.find(params['playlist_id'])
    genre = params[:genre]
    intensity = @playlist.intensity
    user = @playlist.user
    PlaylistManager.populate_playlist(@playlist.spotify_id, genre, intensity, user)
    @tracks = @playlist.tracks || []

    render :show
  end

end