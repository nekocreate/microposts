class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :sting
  end
end
