class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :is_seeker?
      t.boolean :is_company?
      t.timestamps
    end
  end
end