require 'rails_helper'
require 'vcr'

RSpec.describe HeartData do

  describe "heart_data" do
    it "parses fitbit heart data hash" do
      VCR.use_cassette("fitbit/heart_data") do
        heart_data = HTTParty.get "https://api.fitbit.com/1/user/#{ENV['TEST_FITBIT_ID']}/activities/heart/date/today/1w.json"
        result = JSON.parse(heart_data.body)['activities-heart'].last
        last_day_cal = result['value']['heartRateZones'].first['caloriesOut']
        last_day_hr = result['value']['restingHeartRate']
        last_day_date = result['dateTime']

        expect(last_day_cal).to eq(650.88525)
        expect(last_day_hr).to eq(61)
        expect(last_day_date).to eq('2016-06-15')
      end
    end

end



end

