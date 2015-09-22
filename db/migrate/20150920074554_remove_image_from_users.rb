class RemoveImageFromUsers < ActiveRecord::Migration
  def down
    remove_column :users, :image, :string
  end
end
