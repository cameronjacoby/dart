class RenameCategoriesToRoles < ActiveRecord::Migration
  def change
    rename_table :categories, :roles
  end
end