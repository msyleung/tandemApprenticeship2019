require 'json'
require 'active_support/all'
# import Plant module
# maybe I should've put it in app/lib instead of app/helpers
require_relative '../app/helpers/plant'

class App
  extend Plant

  def self.default_settings()
    water_all()
  end

  def self.opt_handler(options)
    if options.include?('-p')
      p_index = options.find_index('-p')
      chosen_plant = options[p_index + 1]
      return water_one(chosen_plant)
    elsif options.include?('-d')
      d_index = options.find_index('-d')
      chosen_date = options[d_index + 1]
      if chosen_date.casecmp('today').zero?
        return one_day('today')
      else
        return one_day(chosen_date)
      end
    elsif options.include?('-a')
      default_settings()
    else
      raise ArgumentError.new($PROGRAM_NAME + ": illegal option\nusage: " +
     $PROGRAM_NAME + ' [-d] [today/date in Y-M-D format] [-p] [specific   plant] [-a] [show all]')
   end
 end
end

# the Main source
if $0 == __FILE__
  App.load_plants()
  if ARGV.length.zero?
    puts App.default_settings()
  elsif !ARGV.empty?
    puts App.opt_handler(ARGV)
  end
end
