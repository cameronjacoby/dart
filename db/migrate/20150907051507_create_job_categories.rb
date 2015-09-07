class CreateJobCategories < ActiveRecord::Migration
  def change
    create_table :job_categories do |t|
      t.belongs_to :job
      t.belongs_to :category
      t.timestamps null: false
    end
  end
end