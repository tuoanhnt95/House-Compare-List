class CreateCompareHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :compare_houses do |t|
      t.text :comment
      t.references :house, null: false, foreign_key: true
      t.references :house_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
