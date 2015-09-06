class AddGuidIndexToJobs < ActiveRecord::Migration
  def change
    add_index :jobs, :guid
  end
end