class SessionsController < ApplicationController

def create
  current_user = User.sign_in_from_omniauth(request.env['omniauth.auth'])
  if current_user
    session[:omniauth] = request.env['omniauth.auth'].except('extra')
    session[:user_id] = current_user.id
    redirect_to spotify_login_path
  else
    redirect_to index_path
  end
end

def complete
  current_user.add_spotify_data(request.env['omniauth.auth'])
  redirect_to dashboard_path
end

def destroy
  session.clear
  redirect_to root_url, notice: 'Signed Out'
end

end