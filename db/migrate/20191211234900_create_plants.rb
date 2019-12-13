class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :water_after
      t.datetime :watered_on, :required => false
    end
  end
end
