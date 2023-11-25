class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.float :price
      t.string :brand
      t.string :model
      t.integer :year
      t.string :title_status
      t.float :mileage
      t.string :color
      t.string :vin
      t.string :lot
      t.string :state
      t.string :country
      t.string :condition
      t.references :manufacturer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
