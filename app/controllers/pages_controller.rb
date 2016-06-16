class PagesController < ApplicationController

def index
  redirect_to :dashboard if current_user
end

def spotify_login
  @user = current_user
end

def dashboard
  @user = current_user
  if @user
    @heart_data = @user.fitbit_data
    @playlists = @user.playlists
  else
    redirect_to :index
  end
end

end