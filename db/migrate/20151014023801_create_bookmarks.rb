class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user
      t.belongs_to :job
      t.timestamps null: false
    end
  end
end