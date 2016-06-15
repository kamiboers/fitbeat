class PagesController < ApplicationController

def index
  redirect_to :dashboard if current_user
  redirect_to :spotify_login if current_user && current_user.logged_fitbit
end

def spotify_login
  @user = current_user
  binding.pry
end

def dashboard
  @user = current_user
  # flash[:success] = "Welcome, #{@user.name} You've successfully logged in."
  response = HTTParty.get "https://api.fitbit.com/1/user/#{@user.fitbit_credential.uid}/activities/heart/date/today/1w.json", headers: {"Authorization" => "Bearer #{@user.fitbit_credential.token}"}
  @heart_data = HeartData.new(response) if response
  response = HTTParty.get "https://api.spotify.com/v1/me/playlists", headers: {"Authorization" => "Bearer #{@user.spotify_credential.token}"}
  @spotify_data = response
  @playlists = @user.playlists
end

end