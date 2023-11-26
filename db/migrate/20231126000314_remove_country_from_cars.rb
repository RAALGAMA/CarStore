# db/migrate/YYYYMMDDHHMMSS_remove_country_from_cars.rb

class RemoveCountryFromCars < ActiveRecord::Migration[6.0]
  def change
    remove_column :cars, :country, :string
  end
end
