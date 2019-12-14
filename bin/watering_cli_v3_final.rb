require './config/environment'

class WateringScheduleCLI < Sinatra::Base

  def self.get_plants(str = Day.today)
    if str.is_a?(String)
      current_day = Day.where(date: Date.parse(str)).first rescue nil
    elsif str.is_a?(Day)
      current_day = str
    end
    if current_day.nil?
      raise ArgumentError.new('Not a date')
    end
    plants_today = current_day.plants
    message = plants_today.size.zero? ? "No plants to water!" : "Please water: #{plants_today.pluck(:name).sort}"
    "The day is #{current_day.date}\n#{message}"
  end

end

if __FILE__ == $PROGRAM_NAME
  puts WateringScheduleCLI.get_plants()
end
