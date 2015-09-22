class AddRetweeidToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :retweetid, :string
  end
end
