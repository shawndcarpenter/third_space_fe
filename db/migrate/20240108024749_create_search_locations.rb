class CreateSearchLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :search_locations do |t|
      t.string :city
      t.string :state
      t.string :address
      t.string :mood
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
