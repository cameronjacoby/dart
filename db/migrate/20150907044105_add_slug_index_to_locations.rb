class AddSlugIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :slug
  end
end