require 'json'
require 'active_support/all'

class Plant

  def load()
    @plants = JSON.parse(File.read('../Tandem_Apprentice_2019_Challenge/Apprentice_WeGrowInTandem_Data.json'))
    today = Time.now
    @start_date = Time.parse('Dec 09 2019')
    # seconds_in_12_weeks = 7257600
    @end_date = @start_date + 12.weeks
  end

  def water_all()
    @plants.each do |plant|
      plant['dates'] = get_watering_dates(plant)
    end
    return @plants
  end

  def water_one(chosen_one)
    found = @plants.select { |plant| plant['name'] == chosen_one }.first
    return found.nil? ? 'Error: plant not found' : get_watering_dates(found)
  end

  def get_watering_dates(plant)
    # get water_after days necessary for each plant
    days = plant['water_after'].split(' ').first.to_i
    # make an array to store all plants & include the first day for easy return
    watering_dates = []
    watering_dates << @start_date
    while watering_dates.last < @end_date
      # get all subsequent watering dates
      # accounting for each plant's watering needs
      next_watering_date = watering_dates.last + days.days
      # check if watering_date == Saturday / Sunday
      if next_watering_date.sunday?
        # water them monday because tolerant plants
        next_watering_date += 1.day
      elsif next_watering_date.saturday?
        # water them on friday
        next_watering_date -= 1.day
      end
      # passed the Saturday / Sunday checks, so save the date!
      watering_dates << next_watering_date
    end
    # return dates to water them
    return watering_dates
  end

  def one_day(date = nil)
    all_watering_dates = water_all()
    if date == 'today'
      # all_watering_dates.select { |watering_dates| }
    else
      plants_to_water = all_watering_dates.select do |plant|
        plant['dates'].include?(Time.parse(date))
      end
      names_of_plant = plants_to_water.map { |plant| plant['name'] }
      return plants_to_water, "\nThere are #{plants_to_water.size} plants to water on #{date} : #{names_of_plant}"
    end
  end

end

# Main Helpers
def default_settings()
  plants = Plant.new()
  plants.load()
  plants.water_all()
end

def opt_handler(options)
  plants = Plant.new()
  if options.include?('-p')
    p_index = options.find_index('-p')
    chosen_plant = options[p_index + 1]
    plants.load()
    return plants.water_one(chosen_plant)
  elsif options.include?('-d')
    d_index = options.find_index('-d')
    chosen_date = options[d_index + 1]
    plants.load()
    if chosen_date.downcase == 'today'
      return plants.one_day('today')
    else
      return plants.one_day(chosen_date)
    end
  elsif options.include?('-a')
    default_settings()
  else
    return $0 + ": illegal option\nusage: " + $0 + ' [-d] [today/date in Y-M-D format] [-p] [specific plant] [-a] [show all]'
  end
end

# the Main source
if ARGV.length == 0
  puts default_settings
elsif ARGV.length > 0
  puts opt_handler(ARGV)
end
