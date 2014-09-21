class AddProfileToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :profile, :json
  end
end