class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.date :date, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    create_table :plant_days do |t|
      t.integer :plant_id, default: 0, null: false
      t.integer :day_id, default: 0, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
