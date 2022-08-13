class CreateHouseLists < ActiveRecord::Migration[7.0]
  def change
    create_table :house_lists do |t|
      t.string :name
      t.string :layout
      t.integer :total_price
      t.float :floor_area
      t.integer :station_distance_time
      t.integer :built_year
      t.integer :floor

      t.timestamps
    end
  end
end
