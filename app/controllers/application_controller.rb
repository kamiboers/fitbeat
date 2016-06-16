class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
    user.refresh_spotify_token if @current_user && (@current_user.spotify_credential.token_expiration < DateTime.now)
    user.refresh_fitbit_token if @current_user && (@current_user.fitbit_credential.token_expiration < DateTime.now)
    @current_user = user
  end


end
