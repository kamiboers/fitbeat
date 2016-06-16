require 'rails_helper'

describe PlaylistsController, type: :controller do

  describe 'GET #index' do
    it 'renders index when user is logged in' do
      user = create_user
      playlist = create_playlist(1, user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:spotify_credential).and_return(standin_credential)
      allow_any_instance_of(User).to receive(:fitbit_credential).and_return(standin_credential)

      get :show, id: playlist.id

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    it 'creates a playlist and redirects to playlist path' do
      VCR.use_cassette('post_playlist') do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:spotify_credential).and_return(spotify_cred_standin)

     expect {
        post :create
      }.to change{ Playlist.count }.by(1)

      expect(response).to have_http_status(:redirect)
    end
    end
  end

  describe 'POST #populate' do
    it 'populates a playlist and redirects to playlist path' do
      VCR.use_cassette('populate_playlist', :record => :new_episodes) do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:spotify_credential).and_return(spotify_cred_standin)

      post :create
      playlist = Playlist.last

      post :populate, :genre => 'pop', :playlist_id => playlist.id

      expect(playlist.tracks.count).to eq(98)
      expect(response).to have_http_status(:success)
    end
    end
  end



end