class AddIntensityToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :intensity, :string
  end
end
