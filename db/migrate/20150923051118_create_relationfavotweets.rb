class CreateRelationfavotweets < ActiveRecord::Migration
  def change
    create_table :relationfavotweets do |t|
      t.references :favoer, index: true
      t.references :tweet, index: true

      t.timestamps null: false
      
      t.index [:favoer_id, :tweet_id], unique: true
    end
  end
end
