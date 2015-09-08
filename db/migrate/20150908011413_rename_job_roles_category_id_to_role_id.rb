class RenameJobRolesCategoryIdToRoleId < ActiveRecord::Migration
  def change
    rename_column :job_roles, :category_id, :role_id
  end
end