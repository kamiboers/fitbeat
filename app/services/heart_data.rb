class HeartData
  attr_reader :rest, :low, :med, :high

  def initialize(data)
    if data['activities-heart']
    data['activities-heart'].each do |day|
      @rest = day['value']['heartRateZones'].first
      @low = day['value']['heartRateZones'][1]
      @med = day['value']['heartRateZones'][2]
      @high = day['value']['heartRateZones'].last
    end
  end
    
    # binding.pry
  end

end