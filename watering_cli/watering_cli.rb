require 'json'
require 'active_support/all'
# import Plant module
# maybe I should've put it in app/lib instead of app/helpers
require_relative '../app/helpers/plant'
include Plant

# Main Helpers
def default_settings()
  load_plants()
  water_all()
end

def opt_handler(options)
  if options.include?('-p')
    p_index = options.find_index('-p')
    chosen_plant = options[p_index + 1]
    load_plants()
    return water_one(chosen_plant)
  elsif options.include?('-d')
    d_index = options.find_index('-d')
    chosen_date = options[d_index + 1]
    load_plants()
    if chosen_date.downcase == 'today'
      return one_day('today')
    else
      return one_day(chosen_date)
       # "\nThere are #{plants_to_water.size} plants to water on #{date} : #{names_of_plant}"
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
