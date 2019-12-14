class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name, default: "", null: false
      t.integer :water_after, default: 0, null: false
      t.datetime :watered_on, required: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
