class FitbitService

  def self.get_heart_data(uid, token)
    HTTParty.get "https://api.fitbit.com/1/user/#{uid}/activities/heart/date/today/1w.json", 
                   headers: {"Authorization" => "Bearer #{token}"}
  end

  def self.get_refresh_token(token)
    auth_code = Base64.strict_encode64("#{ENV['FITBIT_ID']}:#{ENV['FITBIT_KEY']}")
    HTTParty.post "https://api.fitbit.com/oauth2/token", 
                   headers: {"Authorization" => "Basic #{auth_code}"}, 
                   body:  {grant_type: 'refresh_token', refresh_token: token}
  end
end