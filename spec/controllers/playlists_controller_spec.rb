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

  #   describe 'GET #spotify_login' do
  #   it 'renders spotify login successfully when user is logged via fitbit' do
  #     user = create_user
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #     get :spotify_login

  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #dashboard' do
  #   it 'redirects to index when user is logged out' do
  #     get :dashboard

  #     expect(response).to redirect_to(:index)
  #     expect(response).to have_http_status(:redirect)
  #   end

  #   it 'renders dashboard successfully when user is logged in' do
  #     user = create_user
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #     allow_any_instance_of(User).to receive(:fitbit_credential).and_return(standin_credential)
  #     get :dashboard

  #     expect(response).to have_http_status(:success)
  #     expect(response).to render_template(:dashboard)
  #   end
  # end



end