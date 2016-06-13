class HeartData
  attr_reader :hash, :last_day, :last_date, :rest_rate

  def initialize(data)
    if data['activities-heart']
      @hash = {}
      response = data['activities-heart'].each do |day|
        if day['value']['heartRateZones'].last['caloriesOut'] != nil
          @hash[day['dateTime']] = {rest: day['value']['heartRateZones'].first, low: day['value']['heartRateZones'][1], med: day['value']['heartRateZones'][2], high: day['value']['heartRateZones'].last}
          @last_date = day['dateTime']
          @rest_rate = day['value']['restingHeartRate']
          @last_day = {}
          day['value']['heartRateZones'].each do |zone|
            @last_day[zone['name']] = [zone['caloriesOut'], zone['minutes']]
          end
        end
      end
    end
  end


end