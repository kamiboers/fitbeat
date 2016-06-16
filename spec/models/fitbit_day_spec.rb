require 'rails_helper'

RSpec.describe FitbitDay, type: :model do
  it "initializes with attributes" do
    day_data = FitbitDay.new(fitbit_day_hash)
    
    expect(day_data.date).to eq("2016-06-11")
    expect(day_data.rest).to eq(1144.753)
    expect(day_data.low).to eq(544.87675)
    expect(day_data.med).to eq(21.6875)
    expect(day_data.high).to eq(0)
    expect(day_data.rest_rate).to eq(66)
  end

end