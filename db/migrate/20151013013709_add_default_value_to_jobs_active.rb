class AddDefaultValueToJobsActive < ActiveRecord::Migration
  def change
    change_column :jobs, :active, :boolean, default: true
  end
end