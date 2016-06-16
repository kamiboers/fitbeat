require 'rails_helper'

RSpec.describe HeartData, type: :model do
  it "initializes with day data hash" do
    parsed_data = HeartData.new(fitbit_week_hash)

    expect(parsed_data.day_array.count).to eq(6)
    expect(parsed_data.day_array.first.rest).to eq(593.717)
  end

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