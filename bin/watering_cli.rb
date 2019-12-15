require './config/environment'

class WateringScheduleCLI < Sinatra::Base

  def self.date(str)
    if str.is_a?(String)
      current_day = Day.where(date: Date.parse(str)).first rescue nil
    end
    raise ArgumentError.new("#{str} was not found in Day database") if current_day.nil?
    plants_today = current_day.plants
    message = plants_today.size.zero? ? "No plants to water!" : "Please water: #{plants_today.pluck(:name).sort}"
    "The day is #{current_day.date}\n#{message}"
  end

  def self.plant(plant_name)
    plant = Plant.all.select { |p|
      # handles case comparison
      plant_name.casecmp(p.name).zero?
    }.first
    raise ArgumentError.new("#{plant_name} was not found in Plant database") if plant.nil?
    message = "#{plant.name}\nCare instructions: Water after #{plant.water_after} days\nWater on:\n"
    plant.days.each do |d|
      message += "#{d.date}\t"
    end
    message
  end

  def self.all
    message = ''
    Day.all.each do |day|
      next if day.plants.size.zero?
      message += "#{day.date.strftime('%A, %B %d, %Y')}\n"
      message += "#{day.plants.pluck(:name)}\n\n"
    end
    message
  end

end

USAGE = <<ENDUSAGE
Usage: watering_cli.rb [-g guide] [-v] [-d date] date string in 'Y-M-D' format [-p plant] specific plant name [-a show all]
ENDUSAGE

HALP = <<ENDHELP
   -g, --guide      Show this help guide
   -d, --date       Shows all plants to water on given date
   -p, --plant      Shows all dates for given plant
   -a, --all        Displays all plants and dates
ENDHELP

ARGS = { }
UNFLAGGED_ARGS = [ :args ]
next_arg = UNFLAGGED_ARGS.first

ARGV.each do |arg|
  case arg
    when '-g','--guide'     then ARGS[:help]      = true
    when '-d','--date'      then ARGS[:date]      = true
    when '-p','--plant'     then ARGS[:plant]     = true
    when '-a','--all'       then ARGS[:all]       = true
    else
      if next_arg
        ARGS[next_arg] = arg
        UNFLAGGED_ARGS.delete( next_arg )
      end
      next_arg = UNFLAGGED_ARGS.first
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGS[:all]
    puts WateringScheduleCLI.all
  elsif ARGS[:help] or !ARGS[:args]
    puts USAGE
    puts HALP if ARGS[:help]
  elsif ARGS[:plant] and ARGS[:args]
    puts WateringScheduleCLI.plant(ARGS[:args])
  elsif ARGS[:date]
    puts WateringScheduleCLI.date(ARGS[:args])
  end
end
