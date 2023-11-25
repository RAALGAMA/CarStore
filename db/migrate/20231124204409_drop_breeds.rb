class DropBreeds < ActiveRecord::Migration[6.0]
  def up
    drop_table :breeds
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
