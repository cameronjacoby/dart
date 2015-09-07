class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end