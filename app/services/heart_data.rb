class HeartData
  attr_reader :weekly_data, 
              :last_day_data,
              :week_total

  def initialize(data)
    @weekly_data = {}
    @week_total = { rest: 0, low: 0, med: 0, high: 0, heart: 0}
    parse_data(data['activities-heart']) if data['activities-heart']
    @week_total[:heart] = (@week_total[:heart].to_i)/(@weekly_data.count) if @weekly_data.count != 0
  end

  def parse_data(data)
    response = data.each do |day|
      record_daily_data(day) if day_data_exists?(day)
    end
  end

  def day_data_exists?(day)
    day['value']['heartRateZones'].last['caloriesOut'] != nil
  end

  def record_daily_data(day)
    date = day['dateTime']
    rest_data = day['value']['heartRateZones'].first
    low_data = day['value']['heartRateZones'][1]
    med_data = day['value']['heartRateZones'][2]
    high_data = day['value']['heartRateZones'].last

    @weekly_data[date] = {  rest: [ rest_data['caloriesOut'], rest_data['minutes'] ], 
                            low: [ low_data['caloriesOut'], low_data['minutes'] ], 
                            med: [ med_data['caloriesOut'], med_data['minutes'] ], 
                            high: [ high_data['caloriesOut'], high_data['minutes'] ], 
                            resting_rate: day['value']['restingHeartRate']
                         }
    @week_total[:rest] += rest_data['caloriesOut']
    @week_total[:low] += low_data['caloriesOut']
    @week_total[:med] += med_data['caloriesOut']
    @week_total[:high] += high_data['caloriesOut']
    @week_total[:heart] += day['value']['restingHeartRate']

    @last_day_data = @weekly_data[date].merge({ date: date })
  end

end