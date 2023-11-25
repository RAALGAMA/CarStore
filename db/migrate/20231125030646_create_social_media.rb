class CreateSocialMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :social_media do |t|
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :youtube
      t.string :linkedin
      t.references :manufacturer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
