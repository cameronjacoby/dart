class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :category
      t.text :description
      t.text :how_to_apply
      t.references :company
      t.timestamps
    end
  end
end