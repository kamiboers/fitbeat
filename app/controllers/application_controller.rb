class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user.refresh_spotify if @current_user && (@current_user.spotify_credential.token_expiration < DateTime.now)
    @current_user.refresh_fitbit if @current_user && (@current_user.spotify_credential.token_expiration < DateTime.now)
    @current_user
  end


end
