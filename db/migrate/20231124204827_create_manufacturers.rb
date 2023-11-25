class CreateManufacturers < ActiveRecord::Migration[7.0]
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.string :site

      t.timestamps
    end
  end
end
