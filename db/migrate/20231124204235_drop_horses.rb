class DropHorses < ActiveRecord::Migration[7.0]
  def up
    drop_table :horses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
