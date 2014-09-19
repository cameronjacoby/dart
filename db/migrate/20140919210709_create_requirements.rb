class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.references :job
      t.references :skill
      t.timestamps
    end
  end
end