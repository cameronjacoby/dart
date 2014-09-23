class AddClicksToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :clicks, :integer
  end
end