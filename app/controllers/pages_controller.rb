class PagesController < ApplicationController

def index

end

def dashboard
  @user = current_user
  # binding.pry
  # @user.add_spotify_data(auth) if !@user.spotify_uid
end

end