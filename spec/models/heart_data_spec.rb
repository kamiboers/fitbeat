require 'rails_helper'

RSpec.describe HeartData, type: :model do
  it "initializes with day data hash" do
    parsed_data = HeartData.new(fitbit_week_hash)
    
    expect(parsed_data.day_array.count).to eq(6)
    expect(parsed_data.day_array.first.rest).to eq(593.717)
  end

end