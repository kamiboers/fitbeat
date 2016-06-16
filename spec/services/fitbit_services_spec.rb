require 'rails_helper'

describe FitbitService, type: :service do

  describe '#refresh_token' do
  
    it 'updates a user token and refresh token via fitbit api' do
      VCR.use_cassette('fitbit_token_refresh') do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:fitbit_credential).and_return(standin_credential)

      response = user.refresh_fitbit_token

      expect(user.fitbit_credential.token).to eq("eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NjYwNDQyMDYsInNjb3BlcyI6InJwcm8gcmhyIHJsb2Mgcm51dCByc2xlIHJzZXQgcnNvYyByYWN0Iiwic3ViIjoiNE5WRzREIiwiYXVkIjoiMjI3VERGIiwiaXNzIjoiRml0Yml0IiwidHlwIjoiYWNjZXNzX3Rva2VuIiwiaWF0IjoxNDY2MDQwNjA2fQ.dizM87EGGwAomb9oLw6RRilxyXeo3plXOMs4bk7lm48")
      expect(user.fitbit_credential.refresh_token).to eq("f8b158fd8bdff34ffd1ce371b3fd2887b91e87858dcef581f04830bfbcdc8339")
      
    end
    end
  end

end