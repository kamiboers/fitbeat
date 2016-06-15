require 'rails_helper'

RSpec.describe HeartData do
  
  describe "#parse_data" do
    it "parses a hash of daily heart rate data" do
      api_output = default_heart_hash.as_json
      heart_data = HeartData.new(api_output)
      last_date = heart_data.last_day_data[:date]
      weekly_data = heart_data.weekly_data
      last_date_high_cal = weekly_data[last_date][:high]['caloriesOut']

      expect(weekly_data.count).to eq(2)
      expect(last_date).to eq("2015-08-05")
      expect(last_date_high_cal).to eq(333.33333)
    end
  end

end

