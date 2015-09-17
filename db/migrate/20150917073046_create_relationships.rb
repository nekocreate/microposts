class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      # t.references :follower, index: true
      # t.references :followed, index: true
      t.references :follower, index: true
      t.references :followed, index: true
      # herokuへデプロイするときにエラーになるのでforeign_keyの指定を取り除いておく。理由は？まだわからない

      t.timestamps null: false

      t.index [:follower_id, :followed_id], unique: true
      # 複合インデックスとする
      # この複合インデックスはfollower_idとfollowed_idを組み合わせたときの一意性 (uniquenes: 重複がないこと) を強制するもので、
      # これにより、あるユーザーは別のユーザーを2度以上フォローすることはできなくなります。
    end
  end
end
