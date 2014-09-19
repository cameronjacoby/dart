class CreateSeekers < ActiveRecord::Migration
  def change
    create_table :seekers do |t|
      t.string :first_name
      t.string :last_name
      t.references :user
      t.timestamps
    end
  end
end