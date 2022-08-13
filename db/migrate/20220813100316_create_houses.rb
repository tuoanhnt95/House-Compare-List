class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :layout
      t.decimal :rent_fee
      t.decimal :mng_fee
      t.decimal :lease_deposit
      t.decimal :key_money
      t.decimal :guarantee_deposit
      t.float :floor_area
      t.integer :station_distance_time
      t.integer :built_year
      t.integer :floor

      t.timestamps
    end
  end
end
