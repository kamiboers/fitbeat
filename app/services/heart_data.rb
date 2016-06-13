class HeartData
  attr_reader :weekly_data, 
              :last_date

  def initialize(data)
    @weekly_data = {}
    parse_data(data['activities-heart']) if data['activities-heart']
  end

  def parse_data(data)
    response = data.each do |day|
      record_daily_data(day) if day_data_exists?(day)
      @last_date = day['dateTime']
    end
  end

  def day_data_exists?(day)
    day['value']['heartRateZones'].last['caloriesOut'] != nil
  end

  def record_daily_data(day)
    date = day['dateTime']
    @weekly_data[date] = {  rest: day['value']['heartRateZones'].first, 
                            low: day['value']['heartRateZones'][1], 
                            med: day['value']['heartRateZones'][2], 
                            high: day['value']['heartRateZones'].last,
                            resting_rate: day['value']['restingHeartRate']
                         }
  end

end