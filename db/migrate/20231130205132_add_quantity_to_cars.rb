class AddQuantityToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :quantity, :integer
  end
end
