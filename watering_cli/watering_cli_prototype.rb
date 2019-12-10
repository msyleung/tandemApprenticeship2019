require 'time'
require 'json'

# declaring Time variables here for easy manipulation / alterations later
today = Time.parse('Mar 11 2020')#Time.now
START_DATE = Time.parse('Dec 09 2019 10:00:00')
seconds_in_12_weeks = 7257600
END_DATE = START_DATE + seconds_in_12_weeks
SECONDS_IN_DAY = 86400

def days_to_seconds_converter(day)
  day.to_i * SECONDS_IN_DAY
end

def get_watering_dates(plant)
  # get water_after days necessary for each plant
  days = plant['water_after'].split(' ').first
  # convert it into seconds because Time-math
  water_after_seconds = days_to_seconds_converter(days)
  # make an array to store all plants & include the first day for easy return
  watering_dates = []
  watering_dates << START_DATE
  while watering_dates.last < END_DATE
    # get all subsequent watering dates
    # accounting for each plant's watering needs
    next_watering_date = watering_dates.last + water_after_seconds
    # check if watering_date == Saturday / Sunday
    if next_watering_date.sunday?
      # water them monday because tolerant plants
      next_watering_date += SECONDS_IN_DAY
    elsif next_watering_date.saturday?
      # water them on friday
      next_watering_date -= SECONDS_IN_DAY
    end
    # passed the Saturday / Sunday checks, so save the date!
    watering_dates << next_watering_date
  end
  # return a Hash of the plant and dates to water them
  {plant['name'] => watering_dates}
end

if today < START_DATE || today > END_DATE
  abort "Today is not a watering day!"
else
  # load plants
  plants = JSON.parse(File.read('../Tandem_Apprentice_2019_Challenge/Apprentice_WeGrowInTandem_Data.json'))
  # get watering dates
  watering_dates = []
  plants.each do |plant|
    watering_dates << get_watering_dates(plant)
  end
  puts "#{watering_dates}"
  # sort by plant || sort by date
end
