class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :seeker
      t.references :job
      t.timestamps
    end
  end
end