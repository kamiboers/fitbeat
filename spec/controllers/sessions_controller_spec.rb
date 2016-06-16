require 'rails_helper'
 
describe SessionsController do
 
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:fitbit]
  end
 
  describe "#create" do
 
    it "should successfully create a user" do
      expect {
        post :create, provider: :fitbit
      }.to change{ User.count }.by(1)
    end
 
    it "should successfully create a session" do
      expect(session[:user_id]).to eq(nil)
      
      post :create, provider: :fitbit
      
      expect(session[:user_id]).not_to eq(nil)
    end
 
    it "should redirect the user to the spotify login" do
      post :create, provider: :fitbit
      
      expect(response).to redirect_to :spotify_login
    end
 
  end

  describe "#complete" do
 
    it "should redirect the user to the dashboard" do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:spotify_credential).and_return(standin_credential)
      post :complete, provider: :spotify
      
      expect(response).to redirect_to :dashboard
    end
 
  end
 
  describe "#destroy" do

    before do
      post :create, provider: :fitbit
    end
 
    it "should clear the session" do
      expect(session[:user_id]).not_to eq(nil)

      delete :destroy

      expect(session[:user_id]).to eq(nil)
    end
 
    it "should redirect to the home page" do
      delete :destroy

      expect(response).to redirect_to root_url
    end
  end
 
end