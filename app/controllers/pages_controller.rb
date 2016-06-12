require 'base64'
class PagesController < ApplicationController

def index
  redirect_to :dashboard if current_user
end

def dashboard
  @user = current_user
  yesterday = (DateTime.now - 1.day).strftime("%Y-%m-%d")
  response = HTTParty.get "https://api.fitbit.com/1/user/#{@user.fitbit_credential.uid}/activities/heart/date/today/1w.json", headers: {"Authorization" => "Bearer #{@user.fitbit_credential.token}"}
  @heart_data = HeartData.new(response) if response
  # binding.pry
  response = HTTParty.get "https://api.spotify.com/v1/me/playlists", headers: {"Authorization" => "Bearer #{@user.spotify_credential.token}"}
  @spotify_data = response
end

def spotify_login
  @user = current_user
end

end