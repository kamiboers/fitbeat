class SessionsController < ApplicationController

def create
  auth = request.env["omniauth.auth"]
  session[:omniauth] = auth.except('extra')
  user = User.sign_in_from_omniauth(auth)
  session[:user_id] = user.id

  redirect_to dashboard_path if current_user
  redirect_to index_path if !current_user
end

def complete
  binding.pry
  redirect_to dashboard_path
end

def destroy
  session[:user_id] = nil
  session[:omniauth] = nil
  redirect_to root_url, notice: "Signed Out"
end

end