require 'active_support/all'

class PlantDay < ActiveRecord::Base
  belongs_to :plant
  belongs_to :day

  # a plant can only be watered once per day!
  validates_uniqueness_of :day_id, scope: [:plant_id]

  def test
    42
  end

end
