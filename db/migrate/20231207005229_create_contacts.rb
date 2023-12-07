class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.decimal :phone_number
      t.integer :email

      t.timestamps
    end
  end
end
