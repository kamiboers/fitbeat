class HeartData
  attr_reader :day_array

  def initialize(data)
    parse_data(data['activities-heart']) if data['activities-heart']
  end

  def parse_data(data)
    @day_array = data.map { |day| FitbitDay.new(day) if day_data_exists?(day) }.compact
  end

  def day_data_exists?(day)
    day['value']['heartRateZones'].last['caloriesOut'] != nil
  end

end