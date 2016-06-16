require 'webmock/rspec'
require 'simplecov'
SimpleCov.start 'rails'
require 'vcr'
require 'omniauth'



  OmniAuth.config.test_mode = true
  fitbit_omniauth_hash = {'provider'=>'fitbit_oauth2','uid'=>'4NVG4D','info'=>{'name'=>'Kami','full_name'=>'KamiBoers','display_name'=>'Kami','gender'=>'FEMALE','city'=>'Denver','state'=>'CO','country'=>'US','locale'=>'en_US','timezone'=>'America/Denver'},'credentials'=>{'token'=>'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NjYwNDUxOTMsInNjb3BlcyI6InJwcm8gcmhyIHJudXQgcmxvYyByc2xlIHJzZXQgcnNvYyByYWN0Iiwic3ViIjoiNE5WRzREIiwiYXVkIjoiMjI3VERGIiwiaXNzIjoiRml0Yml0IiwidHlwIjoiYWNjZXNzX3Rva2VuIiwiaWF0IjoxNDY2MDQxNTkzfQ.k7pctzN6dLib3kb1_hEqITEzBZ1kEKQXgIppKuYaUKQ','refresh_token'=>'ee90f1ba0c6bc32f22024976765d13bf44db121b630de7fc1884101d2e087e09','expires_at'=>1466045193}, 'extra'=>{'raw_info'=>{'user'=>{'avatar'=>'fucking avatar'}}}}
  spotify_omniauth_hash = {"provider"=>"spotify","uid"=>"kamiboers","info"=>{"name"=>"KamaraBoers","nickname"=>"kamiboers","email"=>"kamiboers@gmail.com","urls"=>{"spotify"=>"https://open.spotify.com/user/kamiboers"},"image"=>"https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12141611_714151635383216_5368530338298669070_n.jpg?oh=300d19b6d7e9c69a8f66c07b7c6b60d8&oe=57CEF712"},"credentials"=>{"token"=>"BQA6jG9Gg2fZ86ab4NE4pYbwPI9AG4FSOqJgidNbUqvnKKIerZJeVU7kNNqXeaKYG8dhEOguykXV2hPwe_JyMD8vqp5Em6Pj32aRTIo861zrISNfW_MuAEveRcCotVpYkkKSnM-cbWcZCGo8-5y7dX99WHQedJiOd-SFCSOcb75KNSi0LcDW-aVya4ACoS5j8KRpEAOY9U2RFmmBYn6beno8qOtjESINoLThoE_dytLpukUGUZiPewxkaktpomGG6D5xgF1ABw","refresh_token"=>"AQD2JMmyjfvgmi-GQU5r2pm25s8eKI3UALLDE5RJ05tdId-47_E9xxzIZwOr5J-cUwLE-bghJThJzb-oPHJMosz9cmPrM76vOeVwmbmiTV-iDj0TjTlArTf4mSqxOc-GEk0","expires_at"=>1466049315,"expires"=>true},"extra"=>{"raw_info"=>{"country"=>"US","display_name"=>"KamaraBoers","email"=>"kamiboers@gmail.com","external_urls"=>{"spotify"=>"https://open.spotify.com/user/kamiboers"},"followers"=>{"href"=>nil,"total"=>4},"href"=>"https://api.spotify.com/v1/users/kamiboers","id"=>"kamiboers","images"=>[{"height"=>nil,"url"=>"https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12141611_714151635383216_5368530338298669070_n.jpg?oh=300d19b6d7e9c69a8f66c07b7c6b60d8&oe=57CEF712","width"=>nil}],"product"=>"premium","type"=>"user","uri"=>"spotify:user:kamiboers"}}}
 
  OmniAuth.config.add_mock(:fitbit, fitbit_omniauth_hash)
  OmniAuth.config.add_mock(:spotify, spotify_omniauth_hash)


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true  
  end

  def create_user(n=1)
    n.times do |u|
      User.create!( name: Faker::Name.name,
                    email: Faker::Internet.email )
    end
    User.last
  end

  def create_playlist(n=1, user_id=nil)
    n.times do |p|
      Playlist.create!( name: Faker::Name.name, user_id: user_id )
    end
    Playlist.last
  end

  def standin_credential
    FitbitCredential.create!(token: "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NjYwNDI1MjIsInNjb3BlcyI6InJwcm8gcmhyIHJudXQgcmxvYyByc2xlIHJzZXQgcnNvYyByYWN0Iiwic3ViIjoiNE5WRzREIiwiYXVkIjoiMjI3VERGIiwiaXNzIjoiRml0Yml0IiwidHlwIjoiYWNjZXNzX3Rva2VuIiwiaWF0IjoxNDY2MDM4OTIyfQ.2BIHedEuJlpGhldjz29aaS70MiSFcZu9uGbTLiwIFEE", uid: "4NVG4D", avatar_url: "avatar_url", refresh_token: "219ec17f6d8e88b0ffd1d3c29fb637af8b17e71a73e42676c3c05732ce7a015d")
    FitbitCredential.last
  end
  
  def fitbit_day_hash
    {"dateTime"=>"2016-06-11","value"=> {"customHeartRateZones"=>[],  "heartRateZones"=>[{"caloriesOut"=>1144.753,"max"=>95,"min"=>30,"minutes"=>990,"name"=>"Out of Range"},{"caloriesOut"=>544.87675,"max"=>133,"min"=>95,"minutes"=>140,"name"=>"Fat Burn"},{"caloriesOut"=>21.6875,"max"=>161,"min"=>133,"minutes"=>3,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>66}}
  end

  def fitbit_week_hash
    {'activities-heart'=>[{"dateTime"=>"2016-06-09","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"max"=>95,"min"=>30,"name"=>"OutofRange"},{"max"=>133,"min"=>95,"name"=>"FatBurn"},{"max"=>161,"min"=>133,"name"=>"Cardio"},{"max"=>220,"min"=>161,"name"=>"Peak"}]}},{"dateTime"=>"2016-06-10","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"caloriesOut"=>593.717,"max"=>95,"min"=>30,"minutes"=>439,"name"=>"OutofRange"},{"caloriesOut"=>225.3765,"max"=>133,"min"=>95,"minutes"=>69,"name"=>"FatBurn"},{"caloriesOut"=>0,"max"=>161,"min"=>133,"minutes"=>0,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>68}},{"dateTime"=>"2016-06-11","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"caloriesOut"=>1144.753,"max"=>95,"min"=>30,"minutes"=>990,"name"=>"OutofRange"},{"caloriesOut"=>544.87675,"max"=>133,"min"=>95,"minutes"=>140,"name"=>"FatBurn"},{"caloriesOut"=>21.6875,"max"=>161,"min"=>133,"minutes"=>3,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>66}},{"dateTime"=>"2016-06-12","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"caloriesOut"=>1345.319,"max"=>95,"min"=>30,"minutes"=>1261,"name"=>"OutofRange"},{"caloriesOut"=>377.189,"max"=>133,"min"=>95,"minutes"=>107,"name"=>"FatBurn"},{"caloriesOut"=>9.369,"max"=>161,"min"=>133,"minutes"=>2,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>64}},{"dateTime"=>"2016-06-13","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"caloriesOut"=>1450.02625,"max"=>95,"min"=>30,"minutes"=>1363,"name"=>"OutofRange"},{"caloriesOut"=>253.04975,"max"=>133,"min"=>95,"minutes"=>67,"name"=>"FatBurn"},{"caloriesOut"=>0,"max"=>161,"min"=>133,"minutes"=>0,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>64}},{"dateTime"=>"2016-06-14","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"caloriesOut"=>964.8335,"max"=>95,"min"=>30,"minutes"=>904,"name"=>"OutofRange"},{"caloriesOut"=>102.5385,"max"=>133,"min"=>95,"minutes"=>28,"name"=>"FatBurn"},{"caloriesOut"=>0,"max"=>161,"min"=>133,"minutes"=>0,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>62}},{"dateTime"=>"2016-06-15","value"=>{"customHeartRateZones"=>[],"heartRateZones"=>[{"caloriesOut"=>990.07775,"max"=>95,"min"=>30,"minutes"=>994,"name"=>"OutofRange"},{"caloriesOut"=>66.36375,"max"=>133,"min"=>95,"minutes"=>20,"name"=>"FatBurn"},{"caloriesOut"=>0,"max"=>161,"min"=>133,"minutes"=>0,"name"=>"Cardio"},{"caloriesOut"=>0,"max"=>220,"min"=>161,"minutes"=>0,"name"=>"Peak"}],"restingHeartRate"=>61}}]}
  end

  def fitbit_oauth_hash 
    {'provider'=>'fitbit_oauth2','uid'=>'4NVG4D','info'=>{'name'=>'Kami','full_name'=>'KamiBoers','display_name'=>'Kami','gender'=>'FEMALE','city'=>'Denver','state'=>'CO','country'=>'US','locale'=>'en_US','timezone'=>'America/Denver'},'credentials'=>{'token'=>'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NjYwNDUxOTMsInNjb3BlcyI6InJwcm8gcmhyIHJudXQgcmxvYyByc2xlIHJzZXQgcnNvYyByYWN0Iiwic3ViIjoiNE5WRzREIiwiYXVkIjoiMjI3VERGIiwiaXNzIjoiRml0Yml0IiwidHlwIjoiYWNjZXNzX3Rva2VuIiwiaWF0IjoxNDY2MDQxNTkzfQ.k7pctzN6dLib3kb1_hEqITEzBZ1kEKQXgIppKuYaUKQ','refresh_token'=>'ee90f1ba0c6bc32f22024976765d13bf44db121b630de7fc1884101d2e087e09','expires_at'=>1466045193}}
  end


end
