class ChangeIsSeekerAndIsCompanyColumnNames < ActiveRecord::Migration
  def change
    rename_column :users, :is_seeker?, :is_seeker
    rename_column :users, :is_company?, :is_company
  end
end