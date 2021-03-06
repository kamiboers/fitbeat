require 'rails_helper'

describe PagesController, type: :controller do

  describe 'GET #index' do
    it 'renders index successfully when user is logged out' do
      get :index

      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
    end

    it 'redirects to dashboard when user is logged in' do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get :index

      expect(response).to have_http_status(:redirect)
      expect(response.body).to redirect_to(:dashboard)
    end
  end

    describe 'GET #spotify_login' do
    it 'renders spotify login successfully when user is logged via fitbit' do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get :spotify_login

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #dashboard' do
    it 'redirects to index when user is logged out' do
      get :dashboard

      expect(response).to redirect_to(:index)
      expect(response).to have_http_status(:redirect)
    end

    it 'renders dashboard successfully when user is logged in' do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:fitbit_credential).and_return(standin_credential)
      get :dashboard

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:dashboard)
    end
  end



end