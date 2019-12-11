require 'active_support/all'

module Plant

  def load_plants()
    today = Time.now
    @start_date = Time.parse('Dec 09 2019')
    @end_date = @start_date + 12.weeks
    @plants = JSON.parse(File.read('../Tandem_Apprentice_2019_Challenge/Apprentice_WeGrowInTandem_Data.json'))
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
    @all_watering_dates ||= water_all()
    if date == 'today'
      # all_watering_dates.select { |watering_dates| }
    else
      date = date.class == Time ? date : Time.parse(date)
      plants_to_water = @all_watering_dates.select do |plant|
        plant['dates'].include?(date)
      end
      names_of_plant = plants_to_water.map { |plant| plant['name'] }
      return names_of_plant
    end
  end

  def sort_by_plant_dates()
    if !@plant_dates
      @plant_dates = Hash.new(0)
      seconds_between_end_to_start = @end_date - @start_date
      days_between_end_to_start = seconds_between_end_to_start / 1.day #86400 seconds per day
      days_between_end_to_start.to_i.times do |num|
        date = @start_date + num.days
        @plant_dates[date] = one_day(date)
      end
    end
    return @plant_dates
  end

end
