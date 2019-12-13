class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.date :date
    end

    create_table :plant_days do |t|
      t.integer :plant_id
      t.integer :day_id
    end
  end
end
