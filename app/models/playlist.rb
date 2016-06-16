class Playlist < ActiveRecord::Base
  belongs_to :user

  def tracks
    PlaylistManager.retrieve_playlist(user, spotify_id)
  end

end
