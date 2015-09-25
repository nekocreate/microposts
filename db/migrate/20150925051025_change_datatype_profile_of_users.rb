class ChangeDatatypeProfileOfUsers < ActiveRecord::Migration
  def change
    change_column :users, :profile, :string
  end
end
