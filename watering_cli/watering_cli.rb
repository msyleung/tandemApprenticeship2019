require 'time'
require 'json'

today = Time.now
@start_date = Time.parse('Dec 08 2019 10:00:00')
seconds_in_12_weeks = 7257600
@end_date = @start_date + seconds_in_12_weeks

def days_to_seconds_converter(day)
  day.to_i * 86400
end

def get_watering_dates(plant)
  puts plant['name']
  water_after_seconds = days_to_seconds_converter(plant['water_after'][0])
  watering_dates = []
  watering_dates << @start_date
  while watering_dates.last < @end_date
    puts watering_dates.last
    next_watering_date = watering_dates.last + water_after_seconds
    # check if watering_date == Saturday / Sunday
    puts next_watering_date
    watering_dates << next_watering_date
  end
  {plant['name'] => watering_dates}
end

if today < @start_date && today > @end_date
  puts "Today is not a watering day!"
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
