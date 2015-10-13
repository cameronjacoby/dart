class RemoveFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :facebook
    remove_column :users, :google
  end
end