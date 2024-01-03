class CreateLocation < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
