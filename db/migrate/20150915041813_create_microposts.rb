class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content # string ではなく、text 投稿した文章（長い文字列）だから

      t.timestamps null: false
      t.index [:user_id, :created_at] # 更にインデックスを追加する
    end
  end
end
