class CreateJoinTableCarsProvinces < ActiveRecord::Migration[7.0]
  def change
    create_join_table :cars, :provinces do |t|
       t.index [:car_id, :province_id]
       t.index [:province_id, :car_id]
    end
  end
end
