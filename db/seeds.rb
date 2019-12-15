# generate & populate plant db
plant_list = JSON.parse(File.read('./Tandem_Apprentice_2019_Challenge/Apprentice_WeGrowInTandem_Data.json'))

plant_list.each do |plant|
  Plant.create(name: plant['name'], water_after: plant['water_after'].to_i)
  # not find_or_create_by because you can have multiples of the same plant
end

start, finish = Day.set_dates
Day.create_days_in_range(start.date, finish.date)

# water all plants
@plants ||= Plant.all.each do |plant|
  plant.water_all_days(start.date, finish.date)
end
