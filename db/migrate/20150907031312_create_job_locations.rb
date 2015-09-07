class CreateJobLocations < ActiveRecord::Migration
  def change
    create_table :job_locations do |t|
      t.belongs_to :job
      t.belongs_to :location
      t.timestamps null: false
    end
  end
end