class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.decimal :rent_fee
      t.decimal :mng_fee
      t.decimal :lease_deposit
      t.decimal :key_money
      t.decimal :guarantee_deposit

      t.timestamps
    end
  end
end
