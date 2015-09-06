class AddGuidToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :guid, :string
  end
end