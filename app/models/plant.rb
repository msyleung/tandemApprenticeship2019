require 'active_support/all'

class Plant < ActiveRecord::Base
  has_many :plant_days, dependent: :destroy
  has_many :days, through: :plant_days

  validates :name, presence: true
  validates :water_after, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.find_closest_day(day)
    sorted_days = self.days.all.sort_by(&:date)
    if day.between?(sorted_days.first, sorted_days.last)
      # is day between 2 prescheduled watering-day
      # is day one days before/after a preschedule watering-day
    end
  end

  def self.guard_overwater(day)
    if self.days.any?
      closest_day = self.find_closest_day(day)
        # if day does not already exist, make new_day
        # change closest watering-day.ito new_day.id
      # else
        # bounce & yell at person for trying to kill plants
    end
    # if day does not already exist, make new_day if it is within water_after days
    # Day.find_or_create_day(day)
    # change closest watering-day.id to new_day.id
  end

  def water_specific(day)
    # self.guard_overwater(day)
    day = Day.check_weekday(day)
    PlantDay.find_or_create_by(plant_id: self.id, day_id: day.id)
    day.date
  end

  def water_all_days(start_date, end_date)
    result = false
    date = start_date
    while date <= end_date
      self.watered_on = water_specific(date)
      date = self.watered_on + (self.water_after).days
      result = true
    end
    return result
  end

  # this logic does not allow for someone to make a mistake and water on a wrong date
  # if there is a mistake, all future PlantDays should be destroyed
  # and the new start_date for this Plant should be its last_watered_date

end
