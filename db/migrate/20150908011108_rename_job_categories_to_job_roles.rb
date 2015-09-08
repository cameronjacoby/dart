class RenameJobCategoriesToJobRoles < ActiveRecord::Migration
  def change
    rename_table :job_categories, :job_roles
  end
end