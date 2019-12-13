require 'active_support/all'

class Day < ActiveRecord::Base
  has_many :plant_days, dependent: :destroy
  has_many :plants, through: :plant_days

  validates_uniqueness_of :date #there can only be one date

  def self.today
    Day.find_or_create_by(date: Date.today)
  end

  def self.set_dates(start = 'Dec 16 2019', time_in_weeks = 12)
    start_date = Date.parse(start) # takes in a string
    end_date = start_date + time_in_weeks.weeks
    return Day.find_or_create_by(date: start_date), Day.find_or_create_by(date: end_date)
  end

  def self.count_days(start_date, end_date)
    # count days between start_date to end_date, adding one to include end_date
    ((end_date - start_date + 1.day) / 1.day).to_i
  end

  def self.create_days_in_range(start_date, end_date)
    # do a range & generate Days between start_date and end_date
    days_between_end_to_start = Day.count_days(start_date, end_date)
    0..days_between_end_to_start.times do |num|
      Day.find_or_create_by(date: start_date + num.day)
    end
  end

  # def self.find_or_create_day(date) # does this function exist already
  #   (day = Day.where(date: date).first) ? day : Day.create(date: date)
  # end

  def self.check_weekday(date)
    date = date.is_a?(Date) ? date : (Date.parse(date) rescue nil)
    case date.wday
    when 1..5  # Monday - Friday, ya gucci
      Day.find_or_create_by(date: date)
    when 6     # if Saturday, do it Friday
      Day.find_or_create_by(date: date.yesterday)
    when 0     # if Sunday, do it Monday
      Day.find_or_create_by(date: date.tomorrow)
    else       # ??? it shouldn't go here but just in case
      raise StandardError
    end
  end

  # If I create a new Day, can I calculate if there is a plant I would need to water on that new date?

end
