class FitbitDay
  attr_reader :date, :rest, :low, :med, :high, :rest_rate
  
  def initialize(day)
    @date = day['dateTime']
    @rest = day['value']['heartRateZones'].first['caloriesOut']
    @low = day['value']['heartRateZones'][1]['caloriesOut']
    @med = day['value']['heartRateZones'][2]['caloriesOut']
    @high = day['value']['heartRateZones'].last['caloriesOut']
    @rest_rate = day['value']['restingHeartRate']
  end

end